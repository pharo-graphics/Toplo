Class {
	#name : #ToSkinManager,
	#superclass : #Object,
	#instVars : [
		'skinRequestCount',
		'styleSheet',
		'skinStateQueue',
		'skinInstaller',
		'skinUninstaller',
		'installedSkin'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #'skin state generation' }
ToSkinManager >> addSkinStateGeneration: aValuable for: anElement [

	installedSkin addSkinStateGeneration: aValuable for: anElement
	
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
ToSkinManager >> applySkinReinstallIn: anElement [

	self applySkinUninstallerIn: anElement.
	self applySkinInstallerIn: anElement
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> applySkinUninstallerIn: anElement [

	" ask the skin uninstaller (if any) to actually uninstall the skin "
	self skinUninstaller ifNotNil: [ :su | su applyOn: anElement ]
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

{ #category : #'skin - install / uninstall request' }
ToSkinManager >> forceSkinInstaller: aSkinInstaller in: anElement [

	"*** private use only for tests *** "
	
	skinInstaller := aSkinInstaller.
	aSkinInstaller ifNil: [ ^ self ].
	anElement space needSkinInstallPass: true
]

{ #category : #'skin - install / uninstall request' }
ToSkinManager >> forceSkinUninstaller: aSkinUninstaller in: anElement [
	"*** private use only for tests *** "

	skinUninstaller := aSkinUninstaller
]

{ #category : #initialization }
ToSkinManager >> initialize [ 

	super initialize.
	installedSkin := ToUnknownSkin instance.
	skinStateQueue := ToSkinStateQueue new.
	skinRequestCount := 0
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> installSkin: aSkin in: anElement [

	Bloc debugModeEnabled ifTrue: [
			self
				assert: installedSkin isUnknownSkin 
				description: 'The skin must not be already stored!.'.
			self
				assert: [
						anElement eventDispatcher handlers noneSatisfy: [ :h |
							(h isKindOf: ToSkin) and: [ h ~= ToUnknownSkin instance ] ] ]
				description: [ 'The skin must not be already registered!' ] ].

	" store the skin "
	installedSkin := aSkin.
	anElement addEventHandler: installedSkin.
	self skinStateQueue enqueueInstallStateForElement: anElement
]

{ #category : #'accessing - installed skin' }
ToSkinManager >> installedSkin [

	" set from the ToSkin>>onInstalledIn: and ToSkin>>onUninstalledIn: "
	^ installedSkin
]

{ #category : #'accessing - installed skin' }
ToSkinManager >> installedSkinDo: aBlock [

	installedSkin isUnknownSkin ifTrue: [ ^ self ].
	aBlock value: installedSkin
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> onSkinInstallerApplied [

	skinInstaller := nil
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> onSkinUninstallerApplied [

	skinUninstaller := nil
]

{ #category : #'skin - install / uninstall request' }
ToSkinManager >> requestInstallSkinIn: anElement [

	| space |
	space := anElement space.
	skinInstaller ifNil: [ 
			skinRequestCount := skinRequestCount + 1.
			skinInstaller := ToSkinInstaller new ].
	" *** Important point: a skin can be installed instantly.
	This is used to avoid visual flashing effects or lags in some situations: 
	selection or labels updating in lists as examples. 
	But but but it is possible only at the first request. Why ?
	Because requestInstallSkin can be sent many times 
	(as an example during a theme installation). 
	Thus, applying each request instantly could increase time consuming for nothing **** "
	space ifNil: [ ^ self ].
	skinRequestCount = 1 ifFalse: [
			space needSkinInstallPass: true.
			^ self ].
	" then apply the installer now "
	" but before, apply the uninstaller if any"
	skinUninstaller ifNotNil: [ :u | u applyOn: anElement ].
	" finally install the skin"
	skinInstaller applyOn: anElement
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

	installedSkin isUnknownSkin ifTrue: [ ^ self ].
	(skinInstaller notNil and: [ skinInstaller isInstalling ]) ifTrue: [
		^ self ].
	skinUninstaller ifNotNil: [ ^ self ].
	skinUninstaller := ToSkinUninstaller new
]

{ #category : #'skin - install / uninstall request' }
ToSkinManager >> requestUninstallSkinRecursivelyIn: anElement [

	anElement withAllChildrenBreadthFirstDo: [ :child |
		child skinManagerDo: [ :sm | sm requestUninstallSkinIn: child ] ]
]

{ #category : #'skin - install / uninstall request' }
ToSkinManager >> resetSkinRequestCount [ 

	skinRequestCount := 0
]

{ #category : #'accessing - styleSheet' }
ToSkinManager >> setStyleSheet: aStyleSheet in: anElement [

	self styleSheet ifNotNil: [ :prev | prev onUninstalledIn: anElement ].
	styleSheet := aStyleSheet.
	self styleSheet ifNotNil: [ :curr | curr onInstalledIn: anElement ].
	anElement requestSkinApplication
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

	^ skinStateQueue
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

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> uninstallSkinIn: anElement [
	" uninstall the skin "

	installedSkin isUnknownSkin ifTrue: [ ^ self ].
	self skinStateQueue enqueueUninstallStateForElement: anElement.
	" do not wait the next pulse to ensure the uninstallation is done here "
	skinStateQueue applyEnqueuedStatesIn: anElement.
	anElement removeEventHandler: installedSkin.
	installedSkin := ToUnknownSkin instance
]
