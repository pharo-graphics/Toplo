Class {
	#name : #ToSkinManager,
	#superclass : #Object,
	#instVars : [
		'skinInstaller',
		'installedSkin',
		'skinStateQueue',
		'skinUninstaller',
		'defaultSkin',
		'postponedRequestInstallSkin',
		'styleSheet',
		'borderBuilder',
		'textAttributesBuilder',
		'skinManagementEventHandler',
		'skinInstallRequestCount',
		'applySkinInstallerOnFirstRequest',
		'registeredThemeClasses',
		'defaultRawSkin',
		'userData'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #adding }
ToSkinManager >> addDraggedSkinStateGeneration: aValuable for: anElement [

	" add a skin generation action to be evaluated by the states application phase "
	anElement space
		ifNotNil: [ :space | space addDraggedSkinStateGeneration: aValuable ]
		ifNil: [ aValuable value ]
]

{ #category : #adding }
ToSkinManager >> addSkinStateGeneration: aValuable for: anElement [

	" add a skin generation action to be evaluated by the states application phase "
	anElement space
		ifNotNil: [ :space | space addSkinStateGeneration: aValuable ]
		ifNil: [ aValuable value ]
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> applyEnqueuedStatesIn: anElement [
	" run the skin actually by flushing the state queue"

	self skinStateQueue applyEnqueuedStatesIn: anElement
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> applySkinInstallerIn: anElement [
	" ask the skin installer (if any) to actually install the skin "

	self skinInstaller ifNotNil: [ :si | si applyOn: anElement ].
	self installedSkin ifNil: [
		" no installed skin and nothing to install it, hum, smell bad "
		((anElement isKindOf: ToElement) and: [postponedRequestInstallSkin isNil and: [skinInstaller isNil ] ]) ifTrue: [
			Error signal: 'A ToSkinManager has an invalid state' ] ]
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> applySkinInstallerOnFirstRequest [

	^ applySkinInstallerOnFirstRequest
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> applySkinInstallerOnFirstRequest: aBoolean [

	applySkinInstallerOnFirstRequest := aBoolean
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> applySkinUninstallerIn: anElement [

	" ask the skin uninstaller (if any) to actually uninstall the skin "
	self skinUninstaller ifNotNil: [ :su | su applyOn: anElement ]
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> applyStylesIn: anElement [

	self
		deprecated: 'Use applyEnqueuedStatesIn: instead'
		transformWith: '`@receiver applyStylesIn: `@argument'
			-> '`@receiver applyEnqueuedStatesIn: `@argument'.
			
	self installedSkinDo: [ :s | s applyEnqueuedStatesIn: anElement ]
]

{ #category : #'accessing - builders' }
ToSkinManager >> borderBuilder [

	^ borderBuilder ifNil: [ borderBuilder := BlBorderBuilder new ] 
]

{ #category : #accessing }
ToSkinManager >> computeStyleSheetChainIn: anElement [
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

{ #category : #'accessing - raw skin' }
ToSkinManager >> defaultRawSkin [

	^ defaultRawSkin
]

{ #category : #'accessing - default skin' }
ToSkinManager >> defaultSkin [

	^ defaultSkin
]

{ #category : #'accessing - default skin' }
ToSkinManager >> forceDefaultSkin: aSkin in: anElement [

	skinInstallRequestCount := 0.
	defaultSkin := aSkin.
	anElement requestNewSkin
]

{ #category : #testing }
ToSkinManager >> hasPostponedRequestInstallSkin [

	
	^ postponedRequestInstallSkin notNil
]

{ #category : #initialization }
ToSkinManager >> initialize [ 

	super initialize.
	skinInstallRequestCount := 0.
	applySkinInstallerOnFirstRequest := false.
	userData := IdentityDictionary new
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> installSkin: aSkin in: anElement [

	anElement dispatchEvent: (ToSkinInstallStateRequest new skin: aSkin; yourself)
	"self installSkinNow: aSkin in: anElement"
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> installSkinNow: aSkin in: anElement [

	anElement addEventHandler: aSkin.
	self skinStateQueue enqueueInstallStateForElement: anElement
]

{ #category : #'accessing - installed skin' }
ToSkinManager >> installedSkin [

	" set from the ToSkin>>onInstalledIn: and ToSkin>>onUninstalledIn: "
	^ installedSkin
]

{ #category : #'accessing - installed skin' }
ToSkinManager >> installedSkin: aSkin [

	" send from the ToSkin>>onInstalledIn: and ToSkin>>onUninstalledIn: "
	installedSkin := aSkin
]

{ #category : #'accessing - installed skin' }
ToSkinManager >> installedSkinDo: aBlock [

	self installedSkin ifNil: [ ^ self ].
	aBlock value: self installedSkin
]

{ #category : #'element setup' }
ToSkinManager >> isSetUpForTheme: aTheme [

	^ self registeredThemeClasses includes: aTheme class
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> onInstalledIn: anElement [

	registeredThemeClasses := IdentitySet new.
	skinManagementEventHandler := ToSkinManagerEventHandler new.
	anElement addEventHandler: skinManagementEventHandler
]

{ #category : #'skin - installing / uninstalling' }
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

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> registerTheme: aTheme [

	self registeredThemeClasses add: aTheme class
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> registeredThemeClasses [

	^ registeredThemeClasses
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> requestInstallSkinIn: anElement [

	anElement space ifNil: [ ^ self postponeRequestSkinIn: anElement ].
	skinInstallRequestCount := skinInstallRequestCount + 1.
	(skinInstallRequestCount > 1 and: [ self skinInstaller notNil ])
		ifTrue: [ ^ self ].
	" check that the skin related space phases are installed "
	anElement space checkSkinPhases.
	self setSkinInstaller: ToSkinInstaller new in: anElement.
	skinInstallRequestCount > 1 ifTrue: [ ^ self ].
	self applySkinInstallerOnFirstRequest ifFalse: [ ^ self ].
	self skinUninstaller ifNotNil: [ :su | su applyOn: anElement ].
	self skinInstaller applyOn: anElement
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> requestUninstallSkinIn: anElement [
	" having an installer which responds true to isInstalling means that the element 
	is already installing a skin.
	and a #requestNewSkin can be sent during a skin installation.
	Thus, to avoid infinite recurssion, do nothing if a skin installer is 
	already installing"

	| installer |
	anElement installedSkin ifNil: [ ^ self ].
	installer := self skinInstaller.
	(installer notNil and: [ installer isInstalling ]) ifTrue: [ ^ self ].
	self skinUninstaller ifNotNil: [ ^ self ].
	self setSkinUninstaller: ToSkinUninstaller new in: anElement
]

{ #category : #'accessing - raw skin' }
ToSkinManager >> setDefaultRawSkin: aSkin in: anElement [

	defaultRawSkin = aSkin ifTrue: [ ^ self ].
	skinInstallRequestCount := 0.
	defaultRawSkin := aSkin.
	anElement requestNewSkin
]

{ #category : #'accessing - default skin' }
ToSkinManager >> setDefaultSkin: aSkin in: anElement [

	defaultSkin = aSkin ifTrue: [ ^ self ].
	self forceDefaultSkin: aSkin in: anElement
]

{ #category : #accessing }
ToSkinManager >> setSkinInstaller: aSkinInstaller in: anElement [

	skinInstaller := aSkinInstaller.
	aSkinInstaller ifNil: [ ^ self ].
	anElement spaceDo: [ :sp | sp needSkinInstallPass: true ]
]

{ #category : #accessing }
ToSkinManager >> setSkinUninstaller: aSkinUninstaller in: anElement [

	skinUninstaller := aSkinUninstaller.
	aSkinUninstaller ifNil: [ ^ self ].
	anElement spaceDo: [ :sp | sp needSkinInstallPass: true ]
]

{ #category : #'accessing - stylesheet' }
ToSkinManager >> setStyleSheet: aStyleSheet in: anElement [

	self styleSheet ifNotNil: [ :prev | prev onUninstalledIn: anElement ].
	styleSheet := aStyleSheet.
	self styleSheet ifNotNil: [ :curr | curr onInstalledIn: anElement ]
]

{ #category : #'element setup' }
ToSkinManager >> setUpForTheme: aTheme in: anElement [

	(self isSetUpForTheme: aTheme) ifTrue: [ ^ self ].
	self registerTheme: aTheme.
	aTheme setUpElement: anElement
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> skinInstallRequestCount [ 

	^ skinInstallRequestCount
]

{ #category : #accessing }
ToSkinManager >> skinInstaller [ 

	^ skinInstaller 
]

{ #category : #accessing }
ToSkinManager >> skinStateQueue [

	^ skinStateQueue ifNil: [ skinStateQueue := ToSkinStateQueue new ]
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> skinToInstallIn: anElement [
	| theme |
	theme :=  anElement toTheme.
	^ (theme defaultSkinFor: anElement) ifNil: [ theme newSkinFor: anElement ]
]

{ #category : #accessing }
ToSkinManager >> skinUninstaller [

	^ skinUninstaller
]

{ #category : #'accessing - stylesheet' }
ToSkinManager >> styleSheet [

	^ styleSheet
]

{ #category : #'accessing - builders' }
ToSkinManager >> textAttributesBuilder [

	^ textAttributesBuilder ifNil: [
		  textAttributesBuilder := BlTextDelegatedAttributesBuilder new ]
]

{ #category : #'accessing token property' }
ToSkinManager >> tokenPropertyValue: aSymbol from: anElement [
	" look-up following child-parent association 
	for each element, try first to get the property from the local styleStampIndex 
	"

	anElement withAllParentsDo: [ :p |
		p toStyleStore ifNotNil: [ :tst | ^ tst tokenPropertyValue: aSymbol from: p ] ].
	^ nil
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> uninstallSkin: aSkin in: anElement [
	" uninstall the skin "

	anElement dispatchEvent: (ToSkinUninstallStateRequest new skin: aSkin; yourself).

]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> uninstallSkinNow: aSkin in: anElement [

	aSkin ifNil: [ ^ self ].
	self skinStateQueue enqueueUninstallStateForElement: anElement.
	" do not wait the next pulse to ensure the uninstallation is done here "
	self skinStateQueue applyEnqueuedStatesIn: anElement.
	anElement removeEventHandler: aSkin
]

{ #category : #accessing }
ToSkinManager >> userData [ 

	^ userData
]
