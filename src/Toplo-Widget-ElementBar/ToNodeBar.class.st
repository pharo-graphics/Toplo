Class {
	#name : #ToNodeBar,
	#superclass : #ToElementBar,
	#instVars : [
		'selectionModel'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #'instance creation' }
ToNodeBar >> nodeContainerClass [ 

	^ ToNodeBarContainerElement
]

{ #category : #accessing }
ToNodeBar >> selectionModel [

	^ selectionModel
]
