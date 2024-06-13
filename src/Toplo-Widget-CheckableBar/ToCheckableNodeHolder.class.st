Class {
	#name : #ToCheckableNodeHolder,
	#superclass : #ToBarNodeHolder,
	#instVars : [
		'checked',
		'group'
	],
	#category : #'Toplo-Widget-CheckableBar'
}

{ #category : #'t - checkable - accessing' }
ToCheckableNodeHolder >> checked [

	^ checked ifNil: [ checked := false ]
]

{ #category : #'t - checkable - accessing' }
ToCheckableNodeHolder >> checked: aBoolean [

	checked := aBoolean

]

{ #category : #accessing }
ToCheckableNodeHolder >> group [

	^ group
]

{ #category : #accessing }
ToCheckableNodeHolder >> group: aCheckableGroup [

	group := aCheckableGroup
]

{ #category : #accessing }
ToCheckableNodeHolder >> segmentedElement [

	^ self barElement
]

{ #category : #'t - checkable - accessing' }
ToCheckableNodeHolder >> updateSelection [

	checked ifTrue: [
		self selecter selectIndex: self position.
		^ self ].
	self selecter deselectIndex: self position
]
