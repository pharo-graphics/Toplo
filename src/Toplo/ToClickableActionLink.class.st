Class {
	#name : #ToClickableActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToClickableActionLink >> launchableFromEvent: anEvent [
	" evaluate if a click action can be launched from the event "

	" If i'm launched from a kind of popup window, don't launch the action if the event occur just after the window popup (to avoid that a popup menu item action is launched immediately on the mouse-up event that follows the mouse down that open the window). "

	^ anEvent
		  ifNotNil: [
				  | target |
				  target := anEvent currentTarget.
				  target isActionRunnableAfter: anEvent timestamp ]
		  ifNil: [ true ]
]

{ #category : #initialization }
ToClickableActionLink >> linkWith: aClickable [

	| handler |
	super linkWith: aClickable.
	handler := aClickable
		           addEventHandlerOn: aClickable clickEventClass
		           do: [ :event |
				           event consume.
				           " evaluate if the action can be launched "
				           (self launchableFromEvent: event) ifTrue: [
					           self requestNextRunWithEvent: event ] ].
	self addedHandler: handler in: aClickable
]
