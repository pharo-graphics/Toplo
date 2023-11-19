Class {
	#name : #ToCheckMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToElementWithCheckable',
	#classTraits : 'TToElementWithCheckable classTrait',
	#category : 'Toplo-Widget-Menu-Basic'
}

{ #category : #initialization }
ToCheckMenuItem >> buttonClass [

	^ ToCheckbox
]

{ #category : #'t - checkable - accessing' }
ToCheckMenuItem >> checkable [

	^ self button
]

{ #category : #testing }
ToCheckMenuItem >> closeOnMouseEvent [

	^ false
]

{ #category : #'t - element with checkable group' }
ToCheckMenuItem >> rawGroup [

	^ self button rawGroup
]

{ #category : #'t - element with checkable group' }
ToCheckMenuItem >> rawGroup: aGroup [

	self button rawGroup: aGroup
]
