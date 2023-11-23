Class {
	#name : 'ToSkinManager',
	#superclass : 'Object',
	#instVars : [
		'skinInstaller',
		'installedSkin',
		'skinStateQueue',
		'skinUninstaller',
		'defaultSkin',
		'intrinsicStateIndex',
		'postponedRequestInstallSkin'
	],
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'skin application' }
ToSkinManager >> applySkinInstallerIn: anElement [
	" ask the skin installer (if any) to actually install the skin "

	self skinInstaller ifNotNil: [ :si | si applyOn: anElement ].
	self installedSkin ifNil: [
		" no installed skin and nothing to install it, hum, smell bad "
		((anElement isKindOf: ToElement) and: [postponedRequestInstallSkin isNil and: [skinInstaller isNil ] ]) ifTrue: [
			Error signal: 'A ToSkinManager has an invalid state' ] ]
]

{ #category : 'skin application' }
ToSkinManager >> applySkinUninstallerIn: anElement [

	" ask the skin uninstaller (if any) to actually uninstall the skin "
	self skinUninstaller ifNotNil: [ :su | su applyOn: anElement ]
]

{ #category : 'skin application' }
ToSkinManager >> applyStylesIn: anElement [

	" run the skin actually by flushing the state queue"
	self installedSkinDo: [ :s | s applyStylesIn: anElement ]
]

{ #category : 'accessing - skin' }
ToSkinManager >> defaultSkin: aSkin in: anElement [

	defaultSkin = aSkin ifTrue: [ ^ self ].
	self setSkin: aSkin in: anElement

]

{ #category : 'accessing - skin' }
ToSkinManager >> defaultSkinIn: anElement [

	^ defaultSkin ifNil: [
		  | th |
		  th := self lookupThemeFrom: anElement.
		  th newSkinFor: anElement ]
]

{ #category : 'skin application' }
ToSkinManager >> enqueuedIntrinicState: aState [

	intrinsicStateIndex at: aState class put: aState
]

{ #category : 'testing' }
ToSkinManager >> hasPostponedRequestInstallSkin [

	
	^ postponedRequestInstallSkin notNil
]

{ #category : 'initialization' }
ToSkinManager >> initialize [ 

	super initialize.
	" Use an ordered dictionary for intrinsicStateIndex to ensure that an 
	EnableState is always the last state "
	intrinsicStateIndex := OrderedIdentityDictionary new
]

{ #category : 'accessing - skin' }
ToSkinManager >> installSkin: aSkin in: anElement [

	anElement addEventHandler: aSkin.
	aSkin dispatchSkinInstallStateRequestTo: anElement.
	aSkin dispatchSkinInitialStateRequestTo: anElement.

]

{ #category : 'accessing - skin' }
ToSkinManager >> installedSkin [

	" set from the ToSkin>>onInstalledIn: and ToSkin>>onUninstalledIn: "
	^ installedSkin
]

{ #category : 'accessing - skin' }
ToSkinManager >> installedSkin: aSkin [

	" send from the ToSkin>>onInstalledIn: and ToSkin>>onUninstalledIn: "
	installedSkin := aSkin
]

{ #category : 'accessing - skin' }
ToSkinManager >> installedSkinDo: aBlock [

	self installedSkin ifNil: [ ^ self ].
	aBlock value: self installedSkin
]

{ #category : 'skin application' }
ToSkinManager >> intrinsicStatesDo: aBlock [

	intrinsicStateIndex valuesDo: aBlock
]

{ #category : 'accessing' }
ToSkinManager >> lookupThemeFrom: anElement [

	anElement isAttachedToSceneGraph ifFalse: [
		Error signal: 'A not attached element should not ask for its theme' ].
	^ anElement space toTheme
]

{ #category : 'accessing - skin' }
ToSkinManager >> postponeRequestSkinIn: anElement [

	self hasPostponedRequestInstallSkin ifTrue: [ ^ self ].
	postponedRequestInstallSkin := BlEventHandler new.
	postponedRequestInstallSkin eventClass: BlElementAddedToSceneGraphEvent.
	postponedRequestInstallSkin action: [ :evt |
		evt target removeEventHandler: postponedRequestInstallSkin.
		postponedRequestInstallSkin := nil.
		evt target requestInstallSkin ].
	anElement addEventHandler: postponedRequestInstallSkin
]

{ #category : 'accessing - skin' }
ToSkinManager >> requestInstallSkinIn: anElement [

	" first check for the space phases "
	anElement space ifNil: [
		^ self postponeRequestSkinIn: anElement ].
	self skinInstaller ifNotNil: [ 
		^ self ].
	anElement space installSkinPhases.
	self skinInstaller: ToSkinInstaller new
]

{ #category : 'accessing - skin' }
ToSkinManager >> requestUninstallSkinIn: anElement [
	" having an installer which responds true to isInstalling means that the element 
	is already installing a skin.
	and a #requestNewSkin can be sent during a skin instalation.
	Thus, to avoid infinite recurssion, do nothing if a skin installer is already installing"

	| installer |
	installer := self skinInstaller.
	(installer notNil and: [ installer isInstalling ]) ifTrue: [ ^ self ].
	self skinUninstaller ifNotNil: [ ^ self ].
	self skinUninstaller: ToSkinUninstaller new
]

{ #category : 'accessing - skin' }
ToSkinManager >> setSkin: aSkin in: anElement [

	anElement requestUninstallSkin.
	defaultSkin := aSkin.
	anElement requestInstallSkin
]

{ #category : 'accessing' }
ToSkinManager >> skinInstaller [ 

	^ skinInstaller 
]

{ #category : 'accessing' }
ToSkinManager >> skinInstaller: aSkinInstaller [

	skinInstaller := aSkinInstaller 
]

{ #category : 'accessing' }
ToSkinManager >> skinStateQueue [

	^ skinStateQueue ifNil: [ skinStateQueue := ToSkinStateQueue new ]
]

{ #category : 'accessing' }
ToSkinManager >> skinUninstaller [

	^ skinUninstaller
]

{ #category : 'accessing' }
ToSkinManager >> skinUninstaller: aSkinUninstaller [

	skinUninstaller := aSkinUninstaller 
]

{ #category : 'accessing - skin' }
ToSkinManager >> uninstallSkin: aSkin in: anElement [
	" uninstall the skin "

	" have to dispatch UninstallStateRequest *** before *** removeEventHandler:
		If not, the uninstall state then the uninstallLookEvent will not be sent "
	aSkin dispatchSkinUninstallStateRequestTo: anElement.
	" do not wait next pulse to flush skinStateQueue state 
		(to send ToUninstallLookEvent) "
	anElement applyStyles.
	" now remove the skin actually.
		no look event applied until a new skin is installed"
	anElement removeEventHandler: aSkin
]
