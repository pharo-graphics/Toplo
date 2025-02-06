"
I am a ToTreeChildSelector and I am abstract.

My purpose is to hold the behaviour of how to collect what we consider children of an Object (we call DataItem).

Subclass me and override `#children` to define your way of collecting children nodes
"
Class {
	#name : #ToTreeChildSelector,
	#superclass : #Object,
	#instVars : [
		'dataItem'
	],
	#category : #'Toplo-Widget-Tree-Core'
}

{ #category : #accessing }
ToTreeChildSelector >> children [ 

	self subclassResponsibility 
]

{ #category : #accessing }
ToTreeChildSelector >> dataItem [ 

	^ dataItem 
]

{ #category : #accessing }
ToTreeChildSelector >> dataItem: anObject [

	dataItem := anObject 
]
