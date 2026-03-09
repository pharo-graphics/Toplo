Class {
	#name : #ToArrowButtonClickedEvent,
	#superclass : #ToIconicButtonClickedEvent,
	#category : #'Toplo-Widget-Button'
}

{ #category : #sending }
ToArrowButtonClickedEvent >> sendTo: anObject [

	anObject arrowButtonClickedEvent: self
]
