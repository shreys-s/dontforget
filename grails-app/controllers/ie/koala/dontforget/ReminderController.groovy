package ie.koala.dontforget

import org.springframework.dao.DataIntegrityViolationException
import grails.plugin.springsecurity.annotation.Secured

@Secured(['ROLE_USER', 'ROLE_ADMIN'])
class ReminderController {

    static allowedMethods = [create: ['GET', 'POST'], edit: ['GET', 'POST'], delete: 'POST']

    def index() {
        redirect action: 'list', params: params
    }

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [reminderInstanceList: Reminder.list(params), reminderInstanceTotal: Reminder.count()]
    }

    def create() {
		switch (request.method) {
		case 'GET':
        	[reminderInstance: new Reminder(params)]
			break
		case 'POST':
	        def reminderInstance = new Reminder(params)
	        if (!reminderInstance.save(flush: true)) {
	            render view: 'create', model: [reminderInstance: reminderInstance]
	            return
	        }

			flash.message = message(code: 'default.created.message', args: [message(code: 'reminder.label', default: 'Reminder'), reminderInstance.id])
	        redirect action: 'show', id: reminderInstance.id
			break
		}
    }

    def show() {
        def reminderInstance = Reminder.get(params.id)
        if (!reminderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'reminder.label', default: 'Reminder'), params.id])
            redirect action: 'list'
            return
        }

        [reminderInstance: reminderInstance]
    }

    def edit() {
		switch (request.method) {
		case 'GET':
	        def reminderInstance = Reminder.get(params.id)
	        if (!reminderInstance) {
	            flash.message = message(code: 'default.not.found.message', args: [message(code: 'reminder.label', default: 'Reminder'), params.id])
	            redirect action: 'list'
	            return
	        }

	        [reminderInstance: reminderInstance]
			break
		case 'POST':
	        def reminderInstance = Reminder.get(params.id)
	        if (!reminderInstance) {
	            flash.message = message(code: 'default.not.found.message', args: [message(code: 'reminder.label', default: 'Reminder'), params.id])
	            redirect action: 'list'
	            return
	        }

	        if (params.version) {
	            def version = params.version.toLong()
	            if (reminderInstance.version > version) {
	                reminderInstance.errors.rejectValue('version', 'default.optimistic.locking.failure',
	                          [message(code: 'reminder.label', default: 'Reminder')] as Object[],
	                          "Another user has updated this Reminder while you were editing")
	                render view: 'edit', model: [reminderInstance: reminderInstance]
	                return
	            }
	        }

	        reminderInstance.properties = params

	        if (!reminderInstance.save(flush: true)) {
	            render view: 'edit', model: [reminderInstance: reminderInstance]
	            return
	        }

			flash.message = message(code: 'default.updated.message', args: [message(code: 'reminder.label', default: 'Reminder'), reminderInstance.id])
	        redirect action: 'show', id: reminderInstance.id
			break
		}
    }

    def delete() {
        def reminderInstance = Reminder.get(params.id)
        if (!reminderInstance) {
			flash.message = message(code: 'default.not.found.message', args: [message(code: 'reminder.label', default: 'Reminder'), params.id])
            redirect action: 'list'
            return
        }

        try {
            reminderInstance.delete(flush: true)
			flash.message = message(code: 'default.deleted.message', args: [message(code: 'reminder.label', default: 'Reminder'), params.id])
            redirect action: 'list'
        }
        catch (DataIntegrityViolationException e) {
			flash.message = message(code: 'default.not.deleted.message', args: [message(code: 'reminder.label', default: 'Reminder'), params.id])
            redirect action: 'show', id: params.id
        }
    }
}
