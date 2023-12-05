Class {
	#name : 'ToSkinManager',
	#superclass : 'Object',
	#instVars : [
		'skinInstaller',
		'installedSkin',
		'skinStateQueue',
		'skinUninstaller',
		'defaultSkin',
		'postponedRequestInstallSkin',
		'styleSheet',
		'themeClasses',
		'borderBuilder',
		'textAttributesBuilder',
		'skinManagementEventHandler',
		'skinInstallRequestCount',
		'applySkinInstallerOnFirstRequest'
	],
	#category : 'Toplo-Core-Theme',
	#package : 'Toplo',
	#tag : 'Core-Theme'
}

{ #category : 'skin application' }
ToSkinManager >> applyEnqueuedStatesIn: anElement [
	" run the skin actually by flushing the state queue"

	self installedSkinDo: [ :s | s applyEnqueuedStatesIn: anElement ]
]

{ #category : 'skin application' }
ToSkinManager >> applySkinInstallerIn: anElement [
	" ask the skin installer (if any) to actually install the skin "

	self skinInstaller ifNotNil: [ :si | si applyOn: anElement ].
	self installedSkin ifNil: [
		" no installed skin and nothing to install it, hum, smell bad "
		((anElement isKindOf: ToElement) and: [postponedRequestInstallSkin isNil and: [skinInstaller isNil ] ]) ifTrue: [
			Error signal: 'A ToSkinManager has an invalid state' ] ]
]

{ #category : 'accessing' }
ToSkinManager >> applySkinInstallerOnFirstRequest [

	^ applySkinInstallerOnFirstRequest
]

{ #category : 'accessing' }
ToSkinManager >> applySkinInstallerOnFirstRequest: aBoolean [

	applySkinInstallerOnFirstRequest := aBoolean
]

{ #category : 'skin application' }
ToSkinManager >> applySkinUninstallerIn: anElement [

	" ask the skin uninstaller (if any) to actually uninstall the skin "
	self skinUninstaller ifNotNil: [ :su | su applyOn: anElement ]
]

{ #category : 'skin application' }
ToSkinManager >> applyStylesIn: anElement [

	self
		deprecated: 'Use applyEnqueuedStatesIn: instead'
		transformWith: '`@receiver applyStylesIn: `@argument'
			-> '`@receiver applyEnqueuedStatesIn: `@argument'.
			
	self installedSkinDo: [ :s | s applyEnqueuedStatesIn: anElement ]
]

{ #category : 'accessing' }
ToSkinManager >> borderBuilder [

	^ borderBuilder ifNil: [ borderBuilder := BlBorderBuilder new ] 
]

{ #category : 'accessing - skin' }
ToSkinManager >> defaultSkin: aSkin in: anElement [

	defaultSkin = aSkin ifTrue: [ ^ self ].
	self setSkin: aSkin in: anElement

]

{ #category : 'accessing - skin' }
ToSkinManager >> defaultSkinIn: anElement [

	^ defaultSkin ifNil: [ anElement toTheme newSkinFor: anElement ]
]

{ #category : 'testing' }
ToSkinManager >> hasPostponedRequestInstallSkin [

	
	^ postponedRequestInstallSkin notNil
]

{ #category : 'initialization' }
ToSkinManager >> initialize [ 

	super initialize.
	skinInstallRequestCount := 0.
	applySkinInstallerOnFirstRequest := false
]

{ #category : 'accessing - skin' }
ToSkinManager >> installSkin: aSkin in: anElement [

	anElement dispatchEvent: (ToSkinInstallStateRequest new skin: aSkin; yourself)
]

{ #category : 'accessing - skin' }
ToSkinManager >> installSkinNow: aSkin in: anElement [

	anElement addEventHandler: aSkin.
	aSkin onInstallStateRequestIn: anElement.
	self skinStateQueue enqueueInstallStateForElement: anElement.
	self flag: 'Wait to see if one have to apply now. For now, let the normal procedure based on the space phases run'.
	"self skinStateQueue applyOn: anElement"

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
ToSkinManager >> isSetUpForTheme: aTheme [

	^ self themeClasses includes: aTheme class
]

{ #category : 'skin application' }
ToSkinManager >> onInstalledIn: anElement [

	themeClasses := IdentitySet new.
	skinManagementEventHandler := ToSkinManagementEventHandler new.
	anElement addEventHandler: skinManagementEventHandler
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

{ #category : 'skin application' }
ToSkinManager >> registerTheme: aTheme [

	self themeClasses add: aTheme class
]

{ #category : 'accessing - skin' }
ToSkinManager >> requestInstallSkinIn: anElement [
	" first check for the space phases "

	anElement space ifNil: [ ^ self postponeRequestSkinIn: anElement ].
	skinInstallRequestCount := skinInstallRequestCount + 1.
	(skinInstallRequestCount > 1 and: [ self skinInstaller notNil ])
		ifTrue: [ ^ self ].
	anElement space checkSkinPhases.
	self skinInstaller: ToSkinInstaller new.
	skinInstallRequestCount > 1 ifTrue: [ ^ self ].
	self applySkinInstallerOnFirstRequest ifFalse: [ ^ self ].
	self skinInstaller applyOn: anElement
]

{ #category : 'accessing - skin' }
ToSkinManager >> requestUninstallSkinIn: anElement [
	" having an installer which responds true to isInstalling means that the element 
	is already installing a skin.
	and a #requestNewSkin can be sent during a skin instalation.
	Thus, to avoid infinite recurssion, do nothing if a skin installer is already installing"

	| installer |
	anElement installedSkin ifNil: [ ^ self ].
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

{ #category : 'api - hooks' }
ToSkinManager >> setUpForTheme: aTheme in: anElement [

	(self isSetUpForTheme: aTheme) ifTrue: [ ^ self ].
	self registerTheme: aTheme.
	aTheme setUpElementForTheme: anElement
]

{ #category : 'accessing' }
ToSkinManager >> skinInstallRequestCount [ 

	^ skinInstallRequestCount
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

{ #category : 'accessing - stylesheet' }
ToSkinManager >> styleSheet [

	^ styleSheet
]

{ #category : 'accessing - stylesheet' }
ToSkinManager >> styleSheet: aStyleSheet in: anElement [

	self styleSheet ifNotNil: [ :prev | prev onUnInstalledIn: anElement ].
	styleSheet := aStyleSheet.
	self styleSheet ifNotNil: [ :curr | curr onInstalledIn: anElement ]
]

{ #category : 'accessing' }
ToSkinManager >> styleSheetChainIn: anElement [
	" return an array with all my inherited stylesheets "

	^ Array new: 20 streamContents: [ :str |
		  | current inherits |
		  current := anElement.
		  inherits := true.
		  [ current notNil and: [ inherits ] ] whileTrue: [
			  current skinManager styleSheet ifNotNil: [ :ss |
				  str nextPut: ss.
				  inherits := ss inherits ].
			  current := current parent ] ]
]

{ #category : 'accessing' }
ToSkinManager >> textAttributesBuilder [

	^ textAttributesBuilder ifNil: [ textAttributesBuilder := BlTextAttributesBuilder new ]
]

{ #category : 'skin application' }
ToSkinManager >> themeClasses [

	^ themeClasses
]

{ #category : 'accessing - skin' }
ToSkinManager >> uninstallSkin: aSkin in: anElement [
	" uninstall the skin "

	anElement dispatchEvent: (ToSkinUninstallStateRequest new skin: aSkin; yourself).

]

{ #category : 'accessing - skin' }
ToSkinManager >> uninstallSkinNow: aSkin in: anElement [

	aSkin ifNil: [ ^ self ].
	aSkin onUninstallStateRequestIn: anElement.
	self skinStateQueue enqueueUninstallStateForElement: anElement.
	" do not wait the next pulse to ensure the uninstallation is done here "
	self skinStateQueue applyEnqueuedStatesIn: anElement.
	anElement removeEventHandler: aSkin
]
