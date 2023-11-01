Class {
	#name : #ToCheckMenuItem,
	#superclass : #ToMenuItem,
	#traits : 'TToElementWithCheckable + TToElementWithCheckbox',
	#classTraits : 'TToElementWithCheckable classTrait + TToElementWithCheckbox classTrait',
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

{ #category : #'t - checkbox - accessing' }
ToCheckMenuItem >> checkbox [

	^ self button
]

{ #category : #testing }
ToCheckMenuItem >> closeOnMouseEvent [

	^ false
]
