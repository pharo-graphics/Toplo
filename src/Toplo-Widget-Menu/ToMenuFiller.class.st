Class {
	#name : #ToMenuFiller,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-Menu-Bar'
}

{ #category : #initialization }
ToMenuFiller >> initialize [

	super initialize.
	self
		id: #filler;
		matchParent
]
