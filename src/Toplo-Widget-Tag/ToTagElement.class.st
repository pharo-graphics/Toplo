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

{ #category : #initialization }
ToTagElement >> initialize [ 

	super initialize.
	self addStamp: #bordered withValue: true.
	self addStamp: #closeIcon withValue: false
]

{ #category : #skin }
ToTagElement >> newRawSkin [

	^ self isCheckable
		  ifTrue: [ ToCheckableTagSkin new ]
		  ifFalse: [ ToTagSkin new ]
]

{ #category : #accessing }
ToTagElement >> rawRemovable [

	^ removable ifNil: [ removable := false ]
]

{ #category : #accessing }
ToTagElement >> rawRemovable: aBoolean [

	removable := aBoolean
]
