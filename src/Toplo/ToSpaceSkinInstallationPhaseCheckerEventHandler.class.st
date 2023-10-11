Class {
	#name : #ToSpaceSkinInstallationPhaseCheckerEventHandler,
	#superclass : #BlCustomEventHandler,
	#category : #'Toplo-Core-SpaceFrame'
}

{ #category : #'event handling' }
ToSpaceSkinInstallationPhaseCheckerEventHandler >> elementAddedToSceneGraphEvent: anEvent [

	" add the Frame if necessary "
	anEvent currentTarget space checkSpaceFrameSkinInstallationPhase.
	" one shot verification - i'm removed for the element event dispatcher "
	anEvent currentTarget removeEventHandler: self
]

{ #category : #'api - accessing' }
ToSpaceSkinInstallationPhaseCheckerEventHandler >> eventsToHandle [

	^ { BlElementAddedToSceneGraphEvent }
]
