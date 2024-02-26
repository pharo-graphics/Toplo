"
My class hierarchy models all the basic actions that can be made on a selection. 

"
Class {
	#name : #ToBasicCommand,
	#superclass : #Object,
	#instVars : [
		'silent'
	],
	#category : #'Toplo-Widget-List-Command'
}

{ #category : #hook }
ToBasicCommand >> applyOn: anObject for: aTarget [
]

{ #category : #accessing }
ToBasicCommand >> silent [

	^ silent ifNil: [ silent := false ]
]

{ #category : #accessing }
ToBasicCommand >> silent: aBoolean [

	silent := aBoolean 
]
