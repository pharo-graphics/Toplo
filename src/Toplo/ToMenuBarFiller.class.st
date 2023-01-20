Class {
	#name : #ToMenuBarFiller,
	#superclass : #ToElement,
	#category : #'Toplo-Widget-MenuBar'
}

{ #category : #initialization }
ToMenuBarFiller >> initialize [

	super initialize.
	self
		id: #'match-parent-fill';
		matchParent
]
