Class {
	#name : #ToSkinManager,
	#superclass : #Object,
	#instVars : [
		'userData',
		'skinRequestCount',
		'skinContext',
		'applySkinInstallerOnFirstRequest',
		'styleSheet',
		'registeredThemeClasses',
		'skinStateQueue',
		'textAttributesBuilder',
		'postponedInstallSkinHandler',
		'skinInstaller',
		'skinUninstaller'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #'skin state generation' }
ToSkinManager >> addSkinStateGeneration: aValuable for: anElement [

	" add a skin generation action to be evaluated by the states application phase "
	anElement space
		ifNotNil: [ :space | space addSkinStateGeneration: aValuable ]
		ifNil: [ aValuable value ]
]

{ #category : #'accessing - skin state queue' }
ToSkinManager >> applyEnqueuedStatesIn: anElement [
	" run the skin actually by flushing the state queue"

	self skinStateQueue applyEnqueuedStatesIn: anElement
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> applySkinInstallerIn: anElement [
	" ask the skin installer (if any) to actually install the skin "

	self skinInstaller ifNotNil: [ :si | si applyOn: anElement ]
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

	^ self skinContext borderBuilder
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> canApplySkinInstallerNowIn: anElement [

	skinRequestCount > 1 ifTrue: [ ^ false ].
	self applySkinInstallerOnFirstRequest ifTrue: [ ^ true ].
	anElement parentDo: [ :p |
		p skinManagerDo: [ :sm |
			(sm canApplySkinInstallerNowIn: p) ifTrue: [ ^ true ] ] ].
	^ false
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

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> enablementChangedIn: anElement [

	self
		addSkinStateGeneration: [
		self skinStateQueue enablementChangedIn: anElement ]
		for: anElement
]

{ #category : #'skin state generation' }
ToSkinManager >> enqueueSkinState: aSkinState in: anElement [

	aSkinState
		requestEnqueueFromElement: anElement
		inQueue: self skinStateQueue
]

{ #category : #'accessing - installed skin' }
ToSkinManager >> ensureHaveSkinContext [

	skinContext ifNil: [ skinContext := ToInstalledSkinContext new ]
]

{ #category : #testing }
ToSkinManager >> hasPostponedInstallSkinHandler [

	
	^ postponedInstallSkinHandler notNil
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

	self ensureHaveSkinContext.
	self skinContext installSkin: aSkin in: anElement.
	self skinStateQueue enqueueInstallStateForElement: anElement.
	anElement onSkinInstalled: aSkin 
]

{ #category : #'accessing - installed skin' }
ToSkinManager >> installedSkin [

	" set from the ToSkin>>onInstalledIn: and ToSkin>>onUninstalledIn: "
	^ self skinContext ifNotNil: [:skc | skc installedSkin ]
]

{ #category : #'accessing - installed skin' }
ToSkinManager >> installedSkinDo: aBlock [

	self installedSkin ifNil: [ ^ self ].
	aBlock value: self installedSkin
]

{ #category : #testing }
ToSkinManager >> isInstallingSkin [

	^ self skinInstaller notNil and: [ self skinInstaller isInstalling ]
]

{ #category : #'element setup' }
ToSkinManager >> isSetUpForTheme: aTheme [

	^ self registeredThemeClasses includes: aTheme class
]

{ #category : #private }
ToSkinManager >> onSkinChangedIn: anElement [

	skinRequestCount := 0.
	self requestNewSkinIn: anElement
]

{ #category : #'skin - install / uninstall request' }
ToSkinManager >> postponeRequestSkinIn: anElement [

	| handler |
	postponedInstallSkinHandler ifNotNil: [ ^ self ].
	handler := BlEventHandler new.
	handler eventClass: ToAddedToSpaceEvent.
	handler action: [ :evt |
		evt target removeEventHandler: postponedInstallSkinHandler.
		postponedInstallSkinHandler := nil.
		self requestInstallSkinIn: evt target ].
	postponedInstallSkinHandler := handler.
	anElement addEventHandler: handler
]

{ #category : #'skin - install / uninstall request' }
ToSkinManager >> postponedInstallSkinHandler [

	^ postponedInstallSkinHandler
]

{ #category : #'element setup' }
ToSkinManager >> registerTheme: aTheme [

	| registered |
	registered := aTheme class.
	self registeredThemeClasses add: aTheme class.
	(registered class canUnderstand: #initializeToploTheme:) ifFalse: [
		^ self ].
	registered class initializeToploTheme: aTheme
]

{ #category : #accessing }
ToSkinManager >> registeredThemeClasses [

	^ registeredThemeClasses ifNil: [ registeredThemeClasses := IdentitySet new ] 
]

{ #category : #'skin - install / uninstall request' }
ToSkinManager >> requestInstallSkinIn: anElement [

	anElement space ifNil: [ ^ self postponeRequestSkinIn: anElement ].
	self skinInstaller ifNil: [ "'requestInstallSkinIn: ' trace. anElement traceCr."
		skinRequestCount := skinRequestCount + 1.
		" check that the skin related space phases are installed "
		self setSkinInstaller: ToSkinInstaller new in: anElement ].
	skinRequestCount = 1 ifFalse: [ ^ self ].
	" *** Important point: a skin can be installed instantly.
	This is used to avoid visual flashing effects in some situations: 
	selection or labels updating in lists as examples. 
	But but but it is possible only at the first request. Why ?
	Because requestInstallSkin can be sent many times 
	(as an example during a theme installation). 
	Thus, applying each request instantly could increase time consuming for nothing **** "
	(self canApplySkinInstallerNowIn: anElement) ifFalse: [ ^ self ].
	" then apply the installer now "
	" but before, apply the uninstaller if any"
	self skinUninstaller ifNotNil: [ :u | u applyOn: anElement ].
	" finally install the skin"
	self skinInstaller applyOn: anElement
]

{ #category : #'skin - install / uninstall request' }
ToSkinManager >> requestNewSkinIn: anElement [

	self requestUninstallSkinIn: anElement.
	self requestInstallSkinIn: anElement
]

{ #category : #'skin - install / uninstall request' }
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
	skinUninstaller := ToSkinUninstaller new
]

{ #category : #'skin - install / uninstall request' }
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

{ #category : #'skin - install / uninstall request' }
ToSkinManager >> setSkinInstaller: aSkinInstaller in: anElement [

	
	skinInstaller := aSkinInstaller.
	aSkinInstaller ifNil: [ ^ self ].
	anElement spaceDo: [ :sp | sp needSkinInstallPass: true ]
]

{ #category : #'skin - install / uninstall request' }
ToSkinManager >> setSkinUninstaller: aSkinUninstaller in: anElement [

	skinUninstaller := aSkinUninstaller
]

{ #category : #'accessing - styleSheet' }
ToSkinManager >> setStyleSheet: aStyleSheet in: anElement [

	self styleSheet ifNotNil: [ :prev | prev onUninstalledIn: anElement ].
	styleSheet := aStyleSheet.
	self styleSheet ifNotNil: [ :curr | curr onInstalledIn: anElement ].
	anElement requestSkinApplication
]

{ #category : #'element setup' }
ToSkinManager >> setUp: anElement forTheme: aTheme [ 

	(self isSetUpForTheme: aTheme) ifTrue: [ ^ self ].
	self registerTheme: aTheme.
	aTheme setUpElement: anElement
]

{ #category : #accessing }
ToSkinManager >> skinContext [

	^ skinContext 
]

{ #category : #accessing }
ToSkinManager >> skinInstaller [ 

	^ skinInstaller
]

{ #category : #'skin - install / uninstall request' }
ToSkinManager >> skinRequestCount [ 

	^ skinRequestCount
]

{ #category : #accessing }
ToSkinManager >> skinStateQueue [

	^ skinStateQueue ifNil: [ skinStateQueue := ToSkinStateQueue new ] 
]

{ #category : #accessing }
ToSkinManager >> skinStateQueue: anObject [

	skinStateQueue := anObject
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> skinToInstallIn: anElement [

	| theme |
	theme := anElement lookupTheme.
	^ (theme defaultSkinFor: anElement) ifNil: [
		  theme newSkinFor: anElement ]
]

{ #category : #accessing }
ToSkinManager >> skinUninstaller [

	^ skinUninstaller 
]

{ #category : #'accessing - styleSheet' }
ToSkinManager >> styleSheet [

	^ styleSheet 
]

{ #category : #'accessing - styleSheet' }
ToSkinManager >> styleSheet: anObject [

	styleSheet := anObject
]

{ #category : #'accessing - builders' }
ToSkinManager >> textAttributesBuilderIn: anElement [

	^ textAttributesBuilder ifNil: [ textAttributesBuilder := anElement newTextAttributesBuilder ]
]

{ #category : #'accessing - token property' }
ToSkinManager >> tokenPropertyValue: aSymbol from: anElement [
	" look-up following child-parent association 
	for each element, try first to get the property from the local styleStampIndex 
	"

	anElement withAllParentsDo: [ :p |
		p toStyleStore ifNotNil: [ :tst | ^ tst tokenPropertyValue: aSymbol from: p ] ].
	^ nil
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> uninstallSkinIn: anElement [
	" uninstall the skin "

	| skin |
	skinContext ifNil: [ ^ self ].
	self skinStateQueue enqueueUninstallStateForElement: anElement.
	" do not wait the next pulse to ensure the uninstallation is done here "
	skinStateQueue applyEnqueuedStatesIn: anElement.
	skin := skinContext installedSkin.
	skinContext uninstallSkinIn: anElement.
	anElement onSkinUninstalled: skin.
	skinContext := nil

]

{ #category : #accessing }
ToSkinManager >> userData [ 

	^ userData
]
