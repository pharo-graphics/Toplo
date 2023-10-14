Class {
	#name : 'ToSpaceSkinInstallerPhaseCheckerEventHandler',
	#superclass : 'BlCustomEventHandler',
	#category : 'Toplo-Core-SpaceFrame',
	#package : 'Toplo',
	#tag : 'Core-SpaceFrame'
}

{ #category : 'event handling' }
ToSpaceSkinInstallerPhaseCheckerEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	" add the Frame if necessary "
	anEvent currentTarget space startSkinInstallerPhase.
	" one shot verification - i'm removed for the element event dispatcher "
	anEvent currentTarget removeEventHandler: self
]

{ #category : 'api - accessing' }
ToSpaceSkinInstallerPhaseCheckerEventHandler >> eventsToHandle [

	^ { BlElementAddedToSceneGraphEvent }
]
