Class {
	#name : #ToCheckableChangedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'checked',
		'sourceEvent'
	],
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'t - checkable  - protocol' }
ToCheckableChangedEvent class >> checked: aBoolean [

	^ self new
		  checked: aBoolean;
		  yourself
]

{ #category : #'t - checkable  - protocol' }
ToCheckableChangedEvent class >> checked: aBoolean onEvent: anEvent [

	^ self new
		  checked: aBoolean;
		  sourceEvent: anEvent;
		  yourself
]

{ #category : #accessing }
ToCheckableChangedEvent >> checked [

	^ checked
]

{ #category : #accessing }
ToCheckableChangedEvent >> checked: aBoolean [

	checked := aBoolean
]

{ #category : #sending }
ToCheckableChangedEvent >> sendTo: anObject [

	anObject checkableChangedEvent: self
]

{ #category : #accessing }
ToCheckableChangedEvent >> sourceEvent [

	^ sourceEvent
]

{ #category : #accessing }
ToCheckableChangedEvent >> sourceEvent: anEvent [

	sourceEvent := anEvent
]
