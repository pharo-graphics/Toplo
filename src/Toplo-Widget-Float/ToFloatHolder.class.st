Class {
	#name : #ToFloatHolder,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-Float'
}

{ #category : #initialization }
ToFloatHolder >> initialize [

	super initialize.
	self fitContent.
	self layout: BlLinearLayout new.
	self constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c ignored vertical alignBottom ]
]

{ #category : #'instance creation' }
ToFloatHolder >> newRawSkin [ 

	^ ToFloatHolderSkin new
]
