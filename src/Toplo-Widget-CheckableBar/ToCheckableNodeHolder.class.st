Class {
	#name : #ToCheckableNodeHolder,
	#superclass : #ToBarNodeHolder,
	#category : #'Toplo-Widget-CheckableBar'
}

{ #category : #accessing }
ToCheckableNodeHolder >> checkableBarElement [

	^ self barElement
]

{ #category : #'t - checkable - accessing' }
ToCheckableNodeHolder >> checked [

	^ self contentElement checked
]

{ #category : #'t - checkable - accessing' }
ToCheckableNodeHolder >> checked: aBoolean [

	self contentElement checked: aBoolean.
	self updateSelection
]

{ #category : #accessing }
ToCheckableNodeHolder >> contentElement [

	^ self dataItem
]

{ #category : #'t - checkable - accessing' }
ToCheckableNodeHolder >> isChecked [ 

	^ self checked
]

{ #category : #'t - checkable - accessing' }
ToCheckableNodeHolder >> updateSelection [

	self contentElement checked ifTrue: [
		self selecter selectIndex: self position.
		^ self ].
	self selecter deselectIndex: self position
]
