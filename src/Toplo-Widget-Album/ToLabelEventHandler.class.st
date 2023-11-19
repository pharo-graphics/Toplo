Class {
	#name : #ToLabelEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : 'Toplo-Widget-Album-Label'
}

{ #category : #'api - accessing' }
ToLabelEventHandler >> eventsToHandle [ 

	^ { BlMouseDownEvent }
]

{ #category : #'event handling' }
ToLabelEventHandler >> mouseDownEvent: anEvent [

	| target |
	target := anEvent currentTarget.
	target isEditable ifFalse: [ ^ self ].
	target editor ifNotNil: [ ^ self ].
	(anEvent modifiers isShift and: [
		 anEvent modifiers isPrimaryModifier ]) ifFalse: [ ^ self ].
	anEvent consumed: true.
	target addEditorEvent: anEvent
]
