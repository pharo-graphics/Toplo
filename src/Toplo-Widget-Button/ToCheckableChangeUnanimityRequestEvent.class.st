Class {
	#name : #ToCheckableChangeUnanimityRequestEvent,
	#superclass : #ToUnanimityRequestEvent,
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'t - checkable - accessing' }
ToCheckableChangeUnanimityRequestEvent >> checked [

	^ sourceEvent checked
]

{ #category : #sending }
ToCheckableChangeUnanimityRequestEvent >> sendTo: anObject [

	anObject checkableChangeUnanimityRequestEvent: self
]
