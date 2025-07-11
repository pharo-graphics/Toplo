Class {
	#name : #ToFloatHolder,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToFloatHolder >> defaultElevation [

	^ BlRelativeElevation elevation: 1
]

{ #category : #initialization }
ToFloatHolder >> defaultLayout [ 

	^ BlLinearLayout new
]

{ #category : #initialization }
ToFloatHolder >> initialize [

	super initialize.
	self fitContent.
	self layout: self defaultLayout.
	self elevation: self defaultElevation
]

{ #category : #'instance creation' }
ToFloatHolder >> newRawSkin [ 

	^ ToFloatHolderSkin new
]
