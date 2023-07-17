Class {
	#name : #ToButtonLabelChanged,
	#superclass : #ToElementPropertyChanged,
	#category : #'Toplo-Widget-Button'
}

{ #category : #sending }
ToButtonLabelChanged >> sendTo: anObject [

	anObject buttonLabelChanged: self
]
