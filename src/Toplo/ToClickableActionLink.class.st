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
	anEvent currentTarget spaceDo: [ :sp |
		| popupTime w |
		" If i'm launched from a kind of popup window, don't launch the action if the event occur just after the window popup (to avoid that an popup menu item is launched immediately after the window popup). this can arise in case of a window position correction to stay visible within its root element bounds"
		w := anEvent currentTarget
			     allParentsDetect: [ :p | p isKindOf: ToAnchoredWindow ]
			     ifFound: [ :p | p ]
			     ifNone: [  ].
		w ifNotNil: [
			popupTime := w popupTimestamp.
			launchable := popupTime isNil or: [anEvent timestamp - popupTime > 300 milliSeconds ] ] ].
	^ launchable
]

{ #category : #initialization }
ToClickableActionLink >> link: anObjectOrValuable withWidget: aClickable [

	| handler |
	handler := aClickable
		           addEventHandlerOn: aClickable clickEventClass
		           do: [ :event |
				           event consume.
				           " evaluate if the action can be launched "
				           (self launchableFromEvent: event) ifTrue: [
					           self runWithEvent: event ] ].
	self addedHandler: handler in: aClickable for: aClickable.

	handler := self
		           addEventHandlerOn: ToRunLinkActionRequest
		           do: [ :event |
				           self
					           onRunLinkActionRequest: event
					           withLinkedObject: anObjectOrValuable
					           fromWidget: aClickable
					           withValue: nil ].
	self addedHandler: handler in: self for: aClickable
]

{ #category : #initialization }
ToClickableActionLink >> onWidget: aClickable [

	| handler |
	handler := aClickable
		           addEventHandlerOn: aClickable clickEventClass
		           do: [ :event |
				           event consume.
				           " evaluate if the action can be launched "
				           (self launchableFromEvent: event) ifTrue: [
					           self runWithEvent: event ] ].
	self addedHandler: handler in: aClickable for: aClickable.

	handler := self
		           addEventHandlerOn: ToRunLinkActionRequest
		           do: [ :event |
				           self
					           onRunLinkActionRequest: event
					           onWidget: aClickable
					           withValue: nil ].
	self addedHandler: handler in: self for: aClickable
]
