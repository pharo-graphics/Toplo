Class {
	#name : 'ToMenuBarFiller',
	#superclass : 'ToElement',
	#category : 'Toplo-Widget-Menu-Bar',
	#package : 'Toplo-Widget-Menu',
	#tag : 'Bar'
}

{ #category : 'initialization' }
ToMenuBarFiller >> initialize [

	super initialize.
	self
		id: #'match-parent-fill';
		matchParent
]
