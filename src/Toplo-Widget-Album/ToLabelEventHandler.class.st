Class {
	#name : #ToLabelEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Widget-Album-Label'
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
	target hasEditor ifTrue: [ ^ self ].
	(anEvent modifiers isShift and: [
		 anEvent modifiers isPrimaryModifier ]) ifFalse: [ ^ self ].
	anEvent consume.
	target popupEditorEvent: anEvent
]
