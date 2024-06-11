Class {
	#name : #ToSegmentHolder,
	#superclass : #ToBarNodeHolder,
	#instVars : [
		'checked',
		'group'
	],
	#category : #'Toplo-Widget-Segmented'
}

{ #category : #'t - checkable - accessing' }
ToSegmentHolder >> checked [

	^ checked ifNil: [ checked := false ]
]

{ #category : #'t - checkable - accessing' }
ToSegmentHolder >> checked: aBoolean [

	checked := aBoolean

]

{ #category : #accessing }
ToSegmentHolder >> group [

	^ group
]

{ #category : #accessing }
ToSegmentHolder >> group: aCheckableGroup [

	group := aCheckableGroup
]

{ #category : #accessing }
ToSegmentHolder >> segmentedElement [

	^ self barElement
]

{ #category : #'t - checkable - accessing' }
ToSegmentHolder >> updateSelection [

	checked ifTrue: [
		self selecter selectIndex: self position.
		^ self ].
	self selecter deselectIndex: self position
]
