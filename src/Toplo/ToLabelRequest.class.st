Class {
	#name : #ToLabelRequest,
	#superclass : #OBlRequest,
	#category : #'Toplo-Widgets'
}

{ #category : #initialization }
ToLabelRequest >> responseClass [
	^ ToLabelChanged
]
