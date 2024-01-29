Class {
	#name : #ToSkinManager,
	#superclass : #Object,
	#instVars : [
		'skinInstaller',
		'skinStateQueue',
		'skinUninstaller',
		'styleSheet',
		'userData',
		'skinRequestCount'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #'skin state generation' }
ToSkinManager >> addDraggedSkinStateGeneration: aValuable for: anElement [

	" add a skin generation action to be evaluated by the states application phase "
	anElement space
		ifNotNil: [ :space | space addDraggedSkinStateGeneration: aValuable ]
		ifNil: [ aValuable value ]
]

{ #category : #'skin state generation' }
ToSkinManager >> addSkinStateGeneration: aValuable in: anElement [

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
		((anElement isKindOf: ToElement) and: [self postponedInstallSkinHandler isNil and: [skinInstaller isNil ] ]) ifTrue: [
			Error signal: 'A ToSkinManager has an invalid state' ] ]
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> applySkinInstallerOnFirstRequest [

	^ self userData at: #applySkinInstallerOnFirstRequest 
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> applySkinInstallerOnFirstRequest: aBoolean [

	self userData at: #applySkinInstallerOnFirstRequest put: aBoolean
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> applySkinReinstallIn: anElement [

	self applySkinUninstallerIn: anElement.
	self applySkinInstallerIn: anElement
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> applySkinUninstallerIn: anElement [

	" ask the skin uninstaller (if any) to actually uninstall the skin "
	self skinUninstaller ifNotNil: [ :su | su applyOn: anElement ]
]

{ #category : #'accessing - builders' }
ToSkinManager >> borderBuilder [

	^ self userData at: #borderBuilder ifAbsentPut: [ BlBorderBuilder new ] 
]

{ #category : #accessing }
ToSkinManager >> computedStyleSheetChainIn: anElement [
	" return an array with all my inherited stylesheets "

	^ Array new: 20 streamContents: [ :str |
		  | current inherits |
		  current := anElement.
		  inherits := true.
		  [ current notNil and: [ inherits ] ] whileTrue: [
			  current skinManagerDo: [ :sm |
				  sm styleSheet ifNotNil: [ :ss |
					  str nextPut: ss.
					  inherits := ss inherits ] ].
			  current := current parent ] ]
]

{ #category : #'accessing - raw skin' }
ToSkinManager >> defaultRawSkin [

	^ self userData at: #defaultRawSkin ifAbsent: [  ]
]

{ #category : #'accessing - raw skin' }
ToSkinManager >> defaultRawSkin: aSkin [

	self userData at: #defaultRawSkin put: aSkin
]

{ #category : #'accessing - default skin' }
ToSkinManager >> defaultSkin [

	^ self userData at: #defaultSkin ifAbsent: [  ]
]

{ #category : #'accessing - default skin' }
ToSkinManager >> defaultSkin: aSkin [

	self userData at: #defaultSkin put: aSkin
]

{ #category : #'skin state generation' }
ToSkinManager >> enqueueSkinState: aSkinState in: anElement [

	aSkinState
		requestEnqueueFromElement: anElement
		inQueue: self skinStateQueue
]

{ #category : #testing }
ToSkinManager >> hasPostponedInstallSkinHandler [

	
	^ self postponedInstallSkinHandler notNil
]

{ #category : #initialization }
ToSkinManager >> initialize [ 

	super initialize.
	userData := IdentityDictionary new.
	skinRequestCount := 0.
	self applySkinInstallerOnFirstRequest: false
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> installSkin: aSkin in: anElement [

	anElement addEventHandler: aSkin.
	self skinStateQueue enqueueInstallStateForElement: anElement
]

{ #category : #'accessing - installed skin' }
ToSkinManager >> installedSkin [

	" set from the ToSkin>>onInstalledIn: and ToSkin>>onUninstalledIn: "
	^ self userData at: #installedSkin ifAbsent: [  ]
]

{ #category : #'accessing - installed skin' }
ToSkinManager >> installedSkin: aSkin [

	" send from the ToSkin>>onInstalledIn: and ToSkin>>onUninstalledIn: "
	self userData at: #installedSkin put: aSkin
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

{ #category : #'api - hooks' }
ToSkinManager >> onInstalledIn: anElement [

	self skinManagementEventHandler: ToSkinManagerEventHandler new.
	anElement addEventHandler: self skinManagementEventHandler
]

{ #category : #private }
ToSkinManager >> onSkinChangedIn: anElement [

	skinRequestCount := 0.
	self requestNewSkinIn: anElement
]

{ #category : #'api - hooks' }
ToSkinManager >> onUninstalledIn: anElement [

	anElement removeEventHandler: self skinManagementEventHandler.
	self skinManagementEventHandler: nil
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> postponeRequestSkinIn: anElement [

	| handler |
	self hasPostponedInstallSkinHandler ifTrue: [ ^ self ].
	handler := BlEventHandler new.
	handler eventClass: BlElementAddedToSceneGraphEvent.
	handler action: [ :evt |
		evt target removeEventHandler: self postponedInstallSkinHandler.
		self postponedInstallSkinHandler: nil.
		self requestInstallSkinIn: evt target ].
	self postponedInstallSkinHandler: handler.
	anElement addEventHandler: handler
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> postponedInstallSkinHandler [

	^ self userData at: #postponedInstallSkinHandler ifAbsent: [  ]
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> postponedInstallSkinHandler: anHandler [

	self userData at: #postponedInstallSkinHandler put: anHandler
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> registerTheme: aTheme [

	self registeredThemeClasses add: aTheme class
]

{ #category : #accessing }
ToSkinManager >> registeredThemeClasses [

	^ self userData at: #registeredThemeClasses ifAbsentPut: [ IdentitySet new ]
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> requestInstallSkinIn: anElement [

	| request |
	anElement space ifNil: [ ^ self postponeRequestSkinIn: anElement ].
	skinRequestCount := skinRequestCount + 1.
	(skinRequestCount > 1 and: [ self skinInstaller notNil ])
		ifTrue: [ ^ self ].
	" check that the skin related space phases are installed "
	anElement space checkSkinPhases.
	anElement dispatchEvent: (request := ToInstallSkinRequest new).
	request accepted ifFalse: [ ^ self ].
	self setSkinInstaller: ToSkinInstaller new in: anElement.
	" *** Important point: a skin can be installed instantly.
	This is used to avoid visual flashing effects in differents situations: (selection or labels updating in lists). 
	but but but it is possible only at the first request. Why ?
	Because requestInstallSkin can be sent many times (as an example during a theme installation). Thus, applying 
	each request instantly would increase time consuming and can lead to unpredictable results **** "
	(self applySkinInstallerOnFirstRequest and: [
		 skinRequestCount = 1 ]) ifFalse: [ ^ self ].
	" If an uninstaller is present, apply it "
	self skinUninstaller ifNotNil: [ :su | su applyOn: anElement ].
	" then apply the installer now "
	self skinInstaller applyOn: anElement
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> requestNewSkinIn: anElement [

	self requestUninstallSkinIn: anElement.
	self requestInstallSkinIn: anElement
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> requestUninstallSkinIn: anElement [
	" having an installer which responds true to isInstalling means that the element 
	is already installing a skin.
	and a #requestNewSkin can be sent during a skin installation.
	Thus, to avoid infinite recurssion, do nothing if a skin installer is 
	being installing"

	| installer |
	(self installedSkin) ifNil: [
		^ self ].
	installer := self skinInstaller.
	(installer notNil and: [ installer isInstalling ]) ifTrue: [ ^ self ].
	self skinUninstaller ifNotNil: [ ^ self ].
	anElement dispatchEvent: ToUninstallSkinRequest new.
	self setSkinUninstaller: ToSkinUninstaller new in: anElement
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> requestUninstallSkinRecursivelyIn: anElement [

	anElement withAllChildrenBreadthFirstDo: [ :child |
		child skinManagerDo: [ :sm | sm requestUninstallSkinIn: child ] ]
]

{ #category : #'accessing - raw skin' }
ToSkinManager >> setDefaultRawSkin: aSkin in: anElement [

	self defaultRawSkin = aSkin ifTrue: [ ^ self ].
	self defaultRawSkin: aSkin.
	self onSkinChangedIn: anElement
]

{ #category : #'accessing - default skin' }
ToSkinManager >> setDefaultSkin: aSkin in: anElement [

	self defaultSkin = aSkin ifTrue: [ ^ self ].
	self defaultSkin: aSkin.
	self onSkinChangedIn: anElement
]

{ #category : #accessing }
ToSkinManager >> setSkinInstaller: aSkinInstaller in: anElement [

	aSkinInstaller ifNotNil: [ anElement spaceDo: [ :sp | sp needSkinInstallPass: true ] ].
	skinInstaller  := aSkinInstaller.
	aSkinInstaller ifNil: [ ^ self ].
	
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

{ #category : #accessing }
ToSkinManager >> skinInstaller [ 

	^ skinInstaller 
]

{ #category : #accessing }
ToSkinManager >> skinManagementEventHandler [

	^ self userData at: #skinManagementEventHandler ifAbsent: [  ]
]

{ #category : #accessing }
ToSkinManager >> skinManagementEventHandler: aHandler [

	self userData at: #skinManagementEventHandler put: aHandler
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> skinRequestCount [ 

	^ skinRequestCount
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

	^ self userData
		  at: #textAttributesBuilder
		  ifAbsentPut: [ BlTextDelegatedAttributesBuilder new ]
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
