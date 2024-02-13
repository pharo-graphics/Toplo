Class {
	#name : #ToMenuBarFiller,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-Menu-Bar'
}

{ #category : #initialization }
ToMenuBarFiller >> initialize [

	super initialize.
	self
		id: #'match-parent-fill';
		matchParent
]
