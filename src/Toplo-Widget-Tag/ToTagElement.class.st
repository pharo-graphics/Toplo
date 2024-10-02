Class {
	#name : #ToTagElement,
	#superclass : #ToButton,
	#traits : 'TToTagElement',
	#classTraits : 'TToTagElement classTrait',
	#instVars : [
		'removable'
	],
	#category : #'Toplo-Widget-Tag-Core'
}

{ #category : #'t - labeled icon' }
ToTagElement >> icon: anElement [

	self iconDo: [ :ic | ic removeStamp: #'parent-tag' ].
	super icon: anElement.
	self iconDo: [ :ic | ic addStamp: #'parent-tag' withValue: self ]
]

{ #category : #initialization }
ToTagElement >> initialize [ 

	super initialize.
	self addStamp: #bordered withValue: true.
	self addStamp: #closeIcon withValue: false
]

{ #category : #'t - labeled icon' }
ToTagElement >> label: anElement [

	self labelDo: [ :lab | lab removeStamp: #'parent-tag' ].
	super label: anElement.
	self labelDo: [ :lab | lab addStamp: #'parent-tag' withValue: self ]
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
