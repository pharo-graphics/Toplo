Class {
	#name : #ToNodeBar,
	#superclass : #ToElementBar,
	#instVars : [
		'selectionModel'
	],
	#category : #'Toplo-Widget-ElementBar'
}

{ #category : #initialization }
ToNodeBar >> initialize [ 

	super initialize.
	self installNodeContainer
]

{ #category : #'instance creation' }
ToNodeBar >> nodeContainerClass [ 

	^ ToNodeBarContainerElement
]

{ #category : #accessing }
ToNodeBar >> selectionModel [

	^ selectionModel
]
