Class {
	#name : #ToSegment,
	#superclass : #ToBarNode,
	#traits : 'TToCheckable',
	#classTraits : 'TToCheckable classTrait',
	#instVars : [
		'checked',
		'group'
	],
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'t - checkable - accessing' }
ToSegment >> rawChecked [

	^ checked ifNil: [ checked := false ]
]

{ #category : #'t - checkable - accessing' }
ToSegment >> rawChecked: aBoolean [

	checked := aBoolean
]

{ #category : #'t - checkable - group' }
ToSegment >> rawGroup [

	^ group
]

{ #category : #'t - checkable - group' }
ToSegment >> rawGroup: aGroup [

	group = aGroup ifTrue: [ ^ self ].
	group := aGroup
]

{ #category : #'t - checkable  - protocol' }
ToSegment >> withIndeterminate [

	^ false
]

{ #category : #'t - checkable  - protocol' }
ToSegment >> withIndeterminate: aBoolean [

	self shouldNotImplement 
]
