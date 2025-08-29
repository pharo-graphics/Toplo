Class {
	#name : #ToSkinManager,
	#superclass : #Object,
	#instVars : [
		'skinRequestCount',
		'styleSheet',
		'skinStateQueue',
		'newSkinRequested',
		'installedSkin',
		'installing'
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

{ #category : #private }
ToSkinManager >> forceNewSkinRequested: aBoolean in: anElement [

	"*** private use only for tests *** "
	
	newSkinRequested := aBoolean.
	newSkinRequested ifFalse: [ ^ self ].
	anElement space needSkinInstallPass: true
]

{ #category : #initialization }
ToSkinManager >> initialize [

	super initialize.

	installing := false.
	newSkinRequested := false.
	installedSkin := ToUnknownSkin instance.
	skinStateQueue := ToSkinStateQueue new.
	skinRequestCount := 0
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> installNewSkinIn: anElement [
	" actually install the skin if requested "

	newSkinRequested ifFalse: [ ^ self ].
	self installingWhile: [
			self uninstallSkinIn: anElement.
			(self skinToInstallIn: anElement) ifNotNil: [ :skin |
				self installSkin: skin in: anElement ].
			" check skin installation "
			installedSkin isUnknownSkin ifTrue: [
				Error signal: 'The skin remains unknown' ].
			" apply style here directly to benefit from the installer recursion protection
					because  requestNewSkin may be sent during skin installation 
					(in that case it it ignored) "
			self applyEnqueuedStatesIn: anElement.
			newSkinRequested := false ]
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> installSkin: aSkin in: anElement [

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
ToSkinManager >> installingWhile: aBlock [

	installing ifTrue: [ ^ self ].
	installing := true.
	aBlock ensure: [ installing := false ]
]

{ #category : #accessing }
ToSkinManager >> newSkinRequested [

	^ newSkinRequested
]

{ #category : #'skin - install / uninstall request' }
ToSkinManager >> requestNewSkinIn: anElement [

	| space |
	space := anElement space.
	newSkinRequested ifFalse: [ 
			skinRequestCount := skinRequestCount + 1.
			newSkinRequested := true ].
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
	"skinUninstaller ifNotNil: [ :u | u applyOn: anElement ]."
	" finally install the skin"
	self installNewSkinIn: anElement
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
