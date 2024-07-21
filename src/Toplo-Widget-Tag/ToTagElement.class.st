Class {
	#name : #ToTagElement,
	#superclass : #ToButton,
	#traits : 'TToTagElement',
	#classTraits : 'TToTagElement classTrait',
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-Tag'
}

{ #category : #accessing }
ToTagElement >> rawRemovable [

	^ removable ifNil: [ removable := false ]
]

{ #category : #accessing }
ToTagElement >> rawRemovable: aBoolean [

	removable := aBoolean
]
