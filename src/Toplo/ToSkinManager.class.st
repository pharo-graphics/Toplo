Class {
	#name : #ToSkinManager,
	#superclass : #Object,
	#instVars : [
		'skinStateQueue',
		'newSkinRequested',
		'installedSkin'
	],
	#category : #'Toplo-Core-Skin'
}

{ #category : #'accessing - skin state queue' }
ToSkinManager >> applyEnqueuedStatesFor: anElement [
	" run the skin actually by flushing the state queue"

	" dispatch to the skin "

	installedSkin applyEnqueuedStatesFor: anElement
]

{ #category : #'skin state generation' }
ToSkinManager >> checkedSkinEvent: aCheckedSkinEvent in: anElement [

	skinStateQueue checkedSkinEvent: aCheckedSkinEvent in: anElement
]

{ #category : #'skin state generation' }
ToSkinManager >> enabledSkinEvent: aSkinEvent in: anElement [

	skinStateQueue enabledSkinEvent: aSkinEvent in: anElement
]

{ #category : #'skin state generation' }
ToSkinManager >> enqueueTransientState: aSkinState for: anElement [

	skinStateQueue enqueueTransientState: aSkinState for: anElement
]

{ #category : #'skin state generation' }
ToSkinManager >> focusedSkinEvent: aSkinEvent in: anElement [

	skinStateQueue focusedSkinEvent: aSkinEvent in: anElement
]

{ #category : #private }
ToSkinManager >> forceNewSkinRequested: aBoolean in: anElement [

	"*** private use only for tests *** "
	
	newSkinRequested := aBoolean.
	newSkinRequested ifFalse: [ ^ self ].
	anElement space ifNil: [ ToSpaceNotFoundError signal ].
	anElement space needSkinInstallPass: true
]

{ #category : #initialization }
ToSkinManager >> initialize [

	super initialize.

	newSkinRequested := false.
	installedSkin := ToUnknownSkin instance.
	skinStateQueue := ToSkinStateQueue new
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> installNewSkinIn: anElement [
	" actually install the skin if requested "

	newSkinRequested ifFalse: [ ^ self ].
	" if my skin is unresolved here it means that I am in a recursive send of myself "
	installedSkin isUnresolvedSkin ifTrue: [ ^ self ].

	self uninstallSkinIn: anElement.

	installedSkin := ToUnresolvedSkin instance.
	(self skinToInstallIn: anElement) ifNotNil: [ :skin |
		self installSkin: skin in: anElement ].

	" if my skin is still unresolved here it means that it is impossible to find the new skin "
	installedSkin isUnresolvedSkin ifTrue: [ ToUnresolvedSkinError signal ].

	" apply style here directly to benefit from the installer recursion protection
	because  requestNewSkin may be sent during skin installation 
	(in that case it it ignored) "
	self applyEnqueuedStatesFor: anElement.

	newSkinRequested := false
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> installSkin: aSkin in: anElement [

	" store the skin "
	aSkin isThemeSkin ifFalse: [ ToUnresolvedSkinError signal ].
	installedSkin := aSkin.
	anElement addEventHandler: installedSkin.
	self skinStateQueue enqueueInstallStateFor: anElement
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

{ #category : #accessing }
ToSkinManager >> newSkinRequested [

	^ newSkinRequested
]

{ #category : #'skin - install / uninstall request' }
ToSkinManager >> requestNewSkinIn: anElement [

	newSkinRequested := true.
	" *** Important point: a skin can be installed instantly.
	This is used to avoid visual flashing effects or lags in some situations: 
	selection or labels updating in lists as examples. 
	But but but it is possible only at the first request. Why ?
	Because requestInstallSkin can be sent many times 
	(as an example during a theme installation). 
	Thus, applying each request instantly could increase time consuming for nothing **** "
	anElement isAttachedToSceneGraph ifFalse: [ ^ self ].
	installedSkin isUnknownSkin ifFalse: [
			anElement space needSkinInstallPass: true.
			^ self ].
	" then apply the installer now "
	" but before, apply the uninstaller if any"
	"skinUninstaller ifNotNil: [ :u | u applyOn: anElement ]."
	" finally install the skin"
	self installNewSkinIn: anElement
]

{ #category : #'skin - install / uninstall request' }
ToSkinManager >> requestReapplySkinStatesIn: anElement [

	(installedSkin isUnknownSkin or: [
		 anElement isAttachedToSceneGraph not ]) ifTrue: [
		^ self requestNewSkinIn: anElement ].

	skinStateQueue enqueueIntrinsicStateFor: anElement.
	anElement spaceDo: [ :sp | sp requestSkinStateApplicationPass ]
]

{ #category : #'skin state generation' }
ToSkinManager >> selectedSkinEvent: aSelectedSkinEvent in: anElement [

	skinStateQueue selectedSkinEvent: aSelectedSkinEvent in: anElement.
	anElement allChildrenBreadthFirstDo: [ :child |
			child skinManagerDo: [ :sm |
				sm skinStateQueue
					selectedSkinEvent: aSelectedSkinEvent copy
					in: child ] ]
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> setSkin: aSkin in: anElement [

	self uninstallSkinIn: anElement.
	self installSkin: aSkin in: anElement
]

{ #category : #accessing }
ToSkinManager >> skinStateQueue [

	^ skinStateQueue
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> skinToInstallIn: anElement [

	^ anElement lookupTheme ifNotNil: [ :theme |
			  | skin |
			  skin := theme defaultSkinFor: anElement.
			  skin setUpforElement: anElement inTheme: theme.
			  skin ]
]

{ #category : #'skin - installing / uninstalling' }
ToSkinManager >> uninstallSkinIn: anElement [
	" uninstall the skin "

	installedSkin isUnknownSkin ifTrue: [ ^ self ].
	installedSkin isUnresolvedSkin ifFalse: [
			self skinStateQueue enqueueUninstallStateFor: anElement.
			anElement removeEventHandler: installedSkin ].
	installedSkin := ToUnknownSkin instance
]
