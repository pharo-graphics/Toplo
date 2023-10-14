"
A ToSpaceSkinInstallerPhaseCheckerEventHandlerTest is a test class for testing the behavior of ToSpaceSkinInstallerPhaseCheckerEventHandler
"
Class {
	#name : 'ToSpaceSkinInstallerPhaseCheckerEventHandlerTest',
	#superclass : 'TestCase',
	#category : 'Toplo-Tests-Core-SpaceFrame',
	#package : 'Toplo-Tests',
	#tag : 'Core-SpaceFrame'
}

{ #category : 'tests' }
ToSpaceSkinInstallerPhaseCheckerEventHandlerTest >> testOnElement [

	| space e |
	space := BlSpace new.
	
	" the skin installer phase should not be installed "
	self assert: space isSkinInstallerPhaseInstalled not.
	
	e := BlElement new.
	
	" no checker installed in the element "
	self assert: (e eventDispatcher handlers noneSatisfy: [ :h |
			 h class == ToSpaceSkinInstallerPhaseCheckerEventHandler ]).

	e addEventHandler: ToSpaceSkinInstallerPhaseCheckerEventHandler new.
	
	" the checker is installed "
	self deny: (e eventDispatcher handlers noneSatisfy: [ :h |
			 h class == ToSpaceSkinInstallerPhaseCheckerEventHandler ]).
		
	" adding the element to the space should induce skin installer phase installation "
	space root addChild: e.
	
	" the skin installer phase is installed "
	self assert: space isSkinInstallerPhaseInstalled.
	
	" no more checker installed in the element "
	self assert: (e eventDispatcher handlers noneSatisfy: [ :h |
			 h class == ToSpaceSkinInstallerPhaseCheckerEventHandler ])
]
