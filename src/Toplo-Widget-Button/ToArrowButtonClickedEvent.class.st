Class {
	#name : #ToArrowButtonClickedEvent,
	#superclass : #ToIconicButtonClickedEvent,
	#category : #'Toplo-Widget-Button-Iconic'
}

{ #category : #sending }
ToArrowButtonClickedEvent >> sendTo: anObject [

	anObject arrowButtonClickedEvent: self
]
