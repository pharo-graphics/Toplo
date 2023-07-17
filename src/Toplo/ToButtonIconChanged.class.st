Class {
	#name : #ToButtonIconChanged,
	#superclass : #ToElementPropertyChanged,
	#category : #'Toplo-Widget-Button'
}

{ #category : #sending }
ToButtonIconChanged >> sendTo: anObject [

	anObject buttonIconChanged: self
]
