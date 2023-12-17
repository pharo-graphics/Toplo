Class {
	#name : 'ToSpaceSkinInstallerPhase',
	#superclass : 'BlSpaceFramePhase',
	#category : 'Toplo-Core-SpaceFrame',
	#package : 'Toplo',
	#tag : 'Core-SpaceFrame'
}

{ #category : 'accessing' }
ToSpaceSkinInstallerPhase >> name [
	<return: #String>
	
	^ 'Skin installer phase'
]

{ #category : 'actions' }
ToSpaceSkinInstallerPhase >> runOn: aSpace [

	" First make a layout pass because installing a skin may require measured/positionned elements "
	aSpace
		dispatchTimeEvent: BlSpaceLayoutEndEvent
		during: [ :theSpace | theSpace doLayout ].
	" Then install the skin "
	aSpace applyAllSkinInstallers
]
