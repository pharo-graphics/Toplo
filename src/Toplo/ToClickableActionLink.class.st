Class {
	#name : #ToClickableActionLink,
	#superclass : #ToActionLink,
	#category : #'Toplo-Core-WidgetLink'
}

{ #category : #initialization }
ToClickableActionLink >> configureToUpdateLinkedObject: anObjectOrValuable from: aClickable [

	| handler |
	handler := aClickable
		           addEventHandlerOn: aClickable clickEventClass
		           do: [ :event | " evaluate if the action can be launched "
			           event consume.
			           (self launchableFromEvent: event) ifTrue: [
				           self
					           launchWithLinkedObject: anObjectOrValuable
					           from: aClickable
					           onEvent: event
					           withValue: nil ] ].
	self addedHandler: handler in: aClickable
]

{ #category : #initialization }
ToClickableActionLink >> launchableFromEvent: anEvent [
	" evaluate if a click action can be launched from the event "

	| launchable |
	" by default: yes "
	launchable := true.
	anEvent currentTarget spaceDo: [ :sp |
		| popupTime w |
		" If i'm launched from a kind of popup window, don't launch the action if the event occur just after the window popup (to avoid that an popup menu item is launched immediately after the window popup). this can arise in case of a window position correction to stay visible within its root element bounds"
		w := anEvent currentTarget
			     allParentsDetect: [ :p | p isKindOf: ToAnchoredWindow ]
			     ifFound: [ :p | p ]
			     ifNone: [  ].
		w ifNotNil: [
			popupTime := w popupTimestamp.
			launchable := anEvent timestamp - popupTime > 500 milliSeconds ] ].
	^ launchable
]
