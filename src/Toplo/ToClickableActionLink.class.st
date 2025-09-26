Class {
	#name : #ToClickableActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToClickableActionLink >> launchableFromEvent: anEvent [
	" evaluate if a click action can be launched from the event "

	| launchable |
	" by default: yes "
	launchable := true.
	" If i'm launched from a kind of popup window, don't launch the action if the event occur just after the window popup (to avoid that an popup menu item is launched immediately after the window popup). this can arise in case of a window position correction to stay visible within its root element bounds"
	anEvent currentTarget
		allParentsDetect: [ :p | p isKindOf: ToAnchoredWindow ]
		ifFound: [ :w |
		launchable := w manager isMinimumDelayBeforeActionRunningExceededOnEvent: anEvent ]
		ifNone: [ ].
	^ launchable
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
