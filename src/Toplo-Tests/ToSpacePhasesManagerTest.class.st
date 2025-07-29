"
A ToSpaceSkinPhasesManagerTest is a test class for testing the behavior of ToSpaceSkinPhasesManager
"
Class {
	#name : #ToSpacePhasesManagerTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core-SpaceFrame'
}

{ #category : #tests }
ToSpacePhasesManagerTest >> testApplyAllConfigurationsIn [

	space phasesManager requestNewConfigurationPass.
	space phasesManager applyAllConfigurationsIn: space.
	self deny: space phasesManager needConfigurationPass 

]

{ #category : #tests }
ToSpacePhasesManagerTest >> testApplyAllEnqueuedStatesIn [

	| e |
	e := ToElement new.
	space root addChild: e.
	space applyAllSkinInstallers.
	e skinManager
		enqueueSkinState: (ToFocusState new focused: true)
		in: e.
	self assert: e skinManager skinStateQueue nextStates size > 0.
	space phasesManager applyAllEnqueuedStatesIn: space.
	self assert: e skinManager skinStateQueue nextStates size equals: 0
]

{ #category : #tests }
ToSpacePhasesManagerTest >> testApplyAllSkinInstallersIn [

	space phasesManager needSkinInstallPass: true.
	space phasesManager applyAllSkinInstallersIn: space.
	self deny: space phasesManager needSkinInstallPass 

]

{ #category : #tests }
ToSpacePhasesManagerTest >> testCheckPhasesIn [

	space checkToploPhases.
	" since space is not opened, the skin phases installation should be postponed "
	self assert: space phasesManager phasesInstallationDone
]

{ #category : #tests }
ToSpacePhasesManagerTest >> testConfigurationPhaseInstalledIn [

	space checkToploPhases.
	" since space is not opened, the skin phases installation should be postponed "
	self assert: (space phasesManager isConfigurationPhaseInstalledIn: space).
]

{ #category : #tests }
ToSpacePhasesManagerTest >> testInitialize [

	| m |
	m := ToSpacePhasesManager new.
	self deny: m phasesInstallationDone.
	self assert: m needSkinInstallPass.
	self assert: m needConfigurationPass 
]

{ #category : #tests }
ToSpacePhasesManagerTest >> testInstalledConfigurationPhaseIn [

	space phasesManager startPhasesIn: space.
	self assert: ((space phasesManager installedConfigurationPhaseIn: space) isKindOf: ToSpaceConfigurationPhase).


]

{ #category : #tests }
ToSpacePhasesManagerTest >> testInstalledSkinInstallerPhaseIn [

	space phasesManager startPhasesIn: space.
	self assert: ((space phasesManager installedSkinInstallerPhaseIn: space) isKindOf: ToSpaceSkinInstallerPhase).


]

{ #category : #tests }
ToSpacePhasesManagerTest >> testInstalledSkinStateApplicationPhaseIn [

	space phasesManager startPhasesIn: space.
	self assert: ((space phasesManager installedSkinStateApplicationPhaseIn: space) isKindOf: ToSpaceSkinStateApplicationPhase).
]

{ #category : #tests }
ToSpacePhasesManagerTest >> testIsSkinInstallerPhaseInstalledIn [

	space checkToploPhases.
	" since space is not opened, the skin phases installation should be postponed "
	self assert: (space phasesManager isSkinInstallerPhaseInstalledIn: space).

]

{ #category : #tests }
ToSpacePhasesManagerTest >> testIsSkinStateApplicationPhaseInstalledIn [

	space checkToploPhases.
	" since space is not opened, the skin phases installation should be postponed "
	self assert: (space phasesManager isSkinStateApplicationPhaseInstalledIn: space).

]

{ #category : #tests }
ToSpacePhasesManagerTest >> testNeedConfigurationPass [

	| e |
	e := ToElement new.
	space applyAllWidgetConfigurations.
	self deny: space phasesManager needConfigurationPass.
	e requestConfiguration.
	space root addChild: e.
	self deny: space phasesManager needConfigurationPass.
	e requestConfiguration.
	self assert: space phasesManager needConfigurationPass.
	space applyAllWidgetConfigurations.
	" all configurations should have been applied "
	self deny: space phasesManager needConfigurationPass
]

{ #category : #tests }
ToSpacePhasesManagerTest >> testNeedSkinInstallPass [

	| e |
	e := ToElement new.
	space applyAllSkinInstallers.
	self deny: space phasesManager needSkinInstallPass.
	space root addChild: e.
	self assert: space phasesManager needSkinInstallPass.
	space applyAllSkinInstallers.
	" all skin installers should have been applied "
	self deny: space phasesManager needSkinInstallPass.
	e addStamp: #stamp.
	self assert: space phasesManager needSkinInstallPass.
	space applyAllSkinInstallers.
	" all skin installers should have been applied "
	self deny: space phasesManager needSkinInstallPass.

	



	
]

{ #category : #tests }
ToSpacePhasesManagerTest >> testNeedSkinStateApplicationPass [

	| e |
	e := ToElement new.
	e applySkinInstallerOnFirstRequest: false.
	space applyAllSkinInstallers.
	self deny: space phasesManager needSkinInstallPass.
	self assert: space phasesManager needSkinStateApplicationPass.
	space applyAllEnqueuedStates.
	self deny: space phasesManager needSkinStateApplicationPass.
	space root addChild: e.
	self assert: space phasesManager needSkinInstallPass.
	self deny: space phasesManager needSkinStateApplicationPass.
	space applyAllSkinInstallers.
	self assert: space phasesManager needSkinStateApplicationPass.
	space applyAllEnqueuedStates.
	self deny: space phasesManager needSkinStateApplicationPass.

	space applyAllSkinInstallers.
	self deny: space phasesManager needSkinStateApplicationPass.
	self deny: space phasesManager needSkinInstallPass.
	e addStamp: #stamp.
	self assert: space phasesManager needSkinInstallPass.
	self deny: space phasesManager needSkinStateApplicationPass.




	
]

{ #category : #tests }
ToSpacePhasesManagerTest >> testOnInstalledIn [

	space checkToploPhases.
	space phasesManager stopPhasesIn: space.
	" here nothing is installed nor postponed"
	space phasesManager onInstalledIn: space.
	" since space is not opened, the skin phases installation should be postponed "
	self assert: space phasesManager phasesInstallationDone
]

{ #category : #tests }
ToSpacePhasesManagerTest >> testOnInstalledIn2 [

	space phasesManager startPhasesIn: space.
	space phasesManager stopPhasesIn: space.
	" here nothing is installed"
	self deny: space phasesManager phasesInstallationDone.
	space phasesManager onInstalledIn: space.
	self assert: space phasesManager phasesInstallationDone.

]

{ #category : #tests }
ToSpacePhasesManagerTest >> testOnUninstalledIn [

	space checkToploPhases.
	" here nothing is installed nor postponed"
	self assert: space phasesManager phasesInstallationDone
]

{ #category : #tests }
ToSpacePhasesManagerTest >> testPhasesInstallationDone [

	self testCheckPhasesIn 
]

{ #category : #tests }
ToSpacePhasesManagerTest >> testStartConfigurationPhaseIn [

	space checkToploPhases.
	space phasesManager onUninstalledIn: space.
	" here nothing is installed nor postponed"
	space phasesManager startSkinInstallerPhaseIn: space.
	space phasesManager startConfigurationPhaseIn: space.
	self assert: (space phasesManager isConfigurationPhaseInstalledIn: space)
]

{ #category : #tests }
ToSpacePhasesManagerTest >> testStartPhasesIn [

	space checkToploPhases.
	" since space is not opened, the skin phases installation should be postponed "
	self assert: (space phasesManager isSkinStateApplicationPhaseInstalledIn: space).
	space phasesManager startPhasesIn: space.
	self assert: (space phasesManager isSkinInstallerPhaseInstalledIn: space).
	self assert: (space phasesManager isSkinStateApplicationPhaseInstalledIn: space).

]

{ #category : #tests }
ToSpacePhasesManagerTest >> testStartSkinInstallerPhaseIn [

	space checkToploPhases.
	space phasesManager onUninstalledIn: space.
	" here nothing is installed nor postponed"
	space phasesManager startSkinInstallerPhaseIn: space.
	self assert: (space phasesManager isSkinInstallerPhaseInstalledIn: space)
]

{ #category : #tests }
ToSpacePhasesManagerTest >> testStartSkinStateApplicationPhaseIn [

	space checkToploPhases.
	space phasesManager onUninstalledIn: space.
	" here nothing is installed nor postponed"
	space phasesManager startSkinStateApplicationPhaseIn: space.
	self assert: (space phasesManager isSkinStateApplicationPhaseInstalledIn: space)
]

{ #category : #tests }
ToSpacePhasesManagerTest >> testStopConfigurationPhaseIn [

	space checkToploPhases.
	space phasesManager onUninstalledIn: space.
	" here nothing is installed nor postponed"
	space phasesManager startSkinInstallerPhaseIn: space.
	space phasesManager startConfigurationPhaseIn: space.
	self assert: (space phasesManager isConfigurationPhaseInstalledIn: space).
	space phasesManager stopConfigurationPhaseIn: space.
	self deny: (space phasesManager isConfigurationPhaseInstalledIn: space).

]

{ #category : #tests }
ToSpacePhasesManagerTest >> testStopPhasesIn [

	space checkToploPhases.
	" since space is not opened, the skin phases installation should be postponed "
	self assert: (space phasesManager isSkinStateApplicationPhaseInstalledIn: space).
	space phasesManager startPhasesIn: space.
	self assert: space phasesManager phasesInstallationDone.
	self assert: (space phasesManager isSkinInstallerPhaseInstalledIn: space).
	self assert: (space phasesManager isSkinStateApplicationPhaseInstalledIn: space).
	space phasesManager stopPhasesIn: space.
	self deny: space phasesManager phasesInstallationDone.
	self deny: (space phasesManager isSkinInstallerPhaseInstalledIn: space).
	self deny: (space phasesManager isSkinStateApplicationPhaseInstalledIn: space).



]

{ #category : #tests }
ToSpacePhasesManagerTest >> testStopSkinInstallerPhaseIn [

	space checkToploPhases.
	space phasesManager onUninstalledIn: space.
	" here nothing is installed nor postponed"
	space phasesManager startSkinInstallerPhaseIn: space.
	self assert: (space phasesManager isSkinInstallerPhaseInstalledIn: space).
	space phasesManager stopSkinInstallerPhaseIn: space.
	self deny: (space phasesManager isSkinInstallerPhaseInstalledIn: space).

]

{ #category : #tests }
ToSpacePhasesManagerTest >> testStopSkinStateApplicationPhaseIn [

	space checkToploPhases.
	space phasesManager onUninstalledIn: space.
	" here nothing is installed nor postponed"
	space phasesManager startSkinStateApplicationPhaseIn: space.
	self assert: (space phasesManager isSkinStateApplicationPhaseInstalledIn: space).
	space phasesManager stopSkinStateApplicationPhaseIn: space.
	self deny: (space phasesManager isSkinStateApplicationPhaseInstalledIn: space)
]
