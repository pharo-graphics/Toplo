Extension { #name : #BlElement }

{ #category : #'*Toplo' }
BlElement >> addAllStamps: aCollectionOfSymbol [

	self toStyleStore addAllStamps: aCollectionOfSymbol
]

{ #category : #'*Toplo' }
BlElement >> addAllTokenProperties: aTokenPropertyCollection [

	self toStyleStore addAllTokenProperties: aTokenPropertyCollection
]

{ #category : #'*Toplo' }
BlElement >> addStamp: aSymbol [


	self toStyleStore addStamp: aSymbol
]

{ #category : #'*Toplo' }
BlElement >> addStamp: aSymbol value: anObject [


	self toStyleStore addStamp: aSymbol value: anObject
]

{ #category : #'*Toplo' }
BlElement >> allStamps [

	^ self toStyleStore allStamps
]

{ #category : #'*Toplo' }
BlElement >> applyEnqueuedStates [

	self skinManager applyEnqueuedStatesIn: self
]

{ #category : #'*Toplo' }
BlElement >> applyEnqueuedStatesRecursively [

	self childrenDo: [ :child | child applyEnqueuedStatesRecursively ].
	self applyEnqueuedStates
]

{ #category : #'*Toplo' }
BlElement >> applySkinInstaller [

	self skinManager applySkinUninstallerIn: self.
	self skinManager applySkinInstallerIn: self
]

{ #category : #'*Toplo' }
BlElement >> applySkinInstallerOnFirstRequest: aBoolean [

	self skinManager applySkinInstallerOnFirstRequest: aBoolean
]

{ #category : #'*Toplo' }
BlElement >> applySkinInstallerRecursively [

	self childrenDo: [ :child | child applySkinInstallerRecursively ].
	self applySkinInstaller.


]

{ #category : #'*Toplo' }
BlElement >> applyStyles [

	self
		deprecated: 'Use applyEnqueuedStates instead'
		transformWith:
		'`@receiver applyStyles' -> '`@receiver applyEnqueuedStates'.
	self skinManager applyEnqueuedStatesIn: self
]

{ #category : #'*Toplo' }
BlElement >> applyStylesRecursively [

	self
		deprecated: 'Use applyEnqueuedStatesRecursively instead'
		transformWith: '`@receiver applyStylesRecursively'
			-> '`@receiver applyEnqueuedStatesRecursively'.
			
	self applyEnqueuedStatesRecursively
]

{ #category : #'*Toplo' }
BlElement >> borderBuilder [

	^ self skinManager borderBuilder
]

{ #category : #'*Toplo' }
BlElement >> defaultSkin [

	^ self skinManager defaultSkinIn: self
]

{ #category : #'*Toplo' }
BlElement >> defaultSkin: aSkin [

	self skinManager defaultSkin: aSkin in: self
]

{ #category : #'*Toplo' }
BlElement >> disable [

	self isDisabled ifFalse: [
		self flagAsDisabled.
		self dispatchEvent: ToEnablementChangedEvent new  ].
	self childrenDo: [ :child | child disable ]
]

{ #category : #'*Toplo' }
BlElement >> enable [

	self isEnabled ifFalse: [
		self flagAsEnabled.
		self dispatchEvent: ToEnablementChangedEvent new ].
	self childrenDo: [ :child | child enable ]
]

{ #category : #'*Toplo' }
BlElement >> enqueueSkinState: aSkinState [

	aSkinState requestEnqueueFromElement: self inQueue:self skinStateQueue
]

{ #category : #'*Toplo' }
BlElement >> flagAsDisabled [

	self userData at: #enabled put: false
]

{ #category : #'*Toplo' }
BlElement >> flagAsEnabled [

	self userData at: #enabled put: true
]

{ #category : #'*Toplo' }
BlElement >> hasEnablementFlag [

	^ self userData includesKey: #enabled
]

{ #category : #'*Toplo' }
BlElement >> hasStamp: aSymbol [


	^ self toStyleStore hasStamp: aSymbol
]

{ #category : #'*Toplo' }
BlElement >> holder [

	^ self constraints infinite holder
]

{ #category : #'*Toplo' }
BlElement >> initialRawStyle [
]

{ #category : #'*Toplo' }
BlElement >> installNewSkinNow [

	" useful for testing purpose. Except this case, do not use this feature that bypass the normal skinRequest/skinInstallation scheme"

	self space ifNil: [
		Error signal:
			'A non attached element can''t ask for an immediate skin change ' ].
	self requestUninstallSkin.
	self skinUninstaller ifNotNil: [:su | su applyOn: self].
	self requestInstallSkin.
	self skinInstaller ifNotNil: [:si | si applyOn: self].
	self spaceDo: [ :sp | sp requestNextPulse ]
]

{ #category : #'*Toplo' }
BlElement >> installRawStyle [

	
]

{ #category : #'*Toplo' }
BlElement >> installedSkin [

	^ self skinManager installedSkin
]

{ #category : #'*Toplo' }
BlElement >> installedSkinDo: aBlock [

	self skinManager installedSkinDo: aBlock
]

{ #category : #'*Toplo' }
BlElement >> isDisabled [

	^ self isEnabled not
]

{ #category : #'*Toplo' }
BlElement >> isEnabled [

	^ self userData at: #enabled ifAbsentPut: [ true ]
]

{ #category : #'*Toplo' }
BlElement >> newRawSkin [

	^  ToRawSkin new
]

{ #category : #'*Toplo' }
BlElement >> openInInnerWindow [

	| frame |
	frame := ToInnerWindow new.
	frame pane addChild: self.
	frame openInSpace
]

{ #category : #'*Toplo' }
BlElement >> removeAllStamps [

	self toStyleStore removeAllStamps
]

{ #category : #'*Toplo' }
BlElement >> removeStamp: aSymbol [

	self toStyleStore removeStamp: aSymbol
]

{ #category : #'*Toplo' }
BlElement >> removeTokenNamed: aSymbol [

	self toStyleStore removeTokenPropertyNamed: aSymbol
]

{ #category : #'*Toplo' }
BlElement >> requestInstallSkin [

	" first check for the space phases "
	self skinManager requestInstallSkinIn: self 
]

{ #category : #'*Toplo' }
BlElement >> requestNewSkin [

	self requestUninstallSkin.
	self requestInstallSkin.
	self spaceDo: [ :sp | sp requestNextPulse ]
]

{ #category : #'*Toplo' }
BlElement >> requestNewSkinRecursively [

	self childrenDo: [ :child | child requestNewSkinRecursively ].
	self requestNewSkin 
]

{ #category : #'*Toplo' }
BlElement >> requestUninstallSkin [

	self skinManager requestUninstallSkinIn: self 
]

{ #category : #'*Toplo' }
BlElement >> requestUninstallSkinRecursively [

	self childrenDo: [ :child | child requestUninstallSkinRecursively ].
	self requestUninstallSkin
]

{ #category : #'*Toplo' }
BlElement >> setSkin: aSkin [

	self skinManager setSkin: aSkin in: self
]

{ #category : #'*Toplo' }
BlElement >> setStamp: aSymbol value: anObject [

	self toStyleStore addStamp: aSymbol value: anObject
]

{ #category : #'*Toplo' }
BlElement >> setToken: aTokenProperty [

	self toStyleStore addTokenProperty: aTokenProperty asTokenProperty 
]

{ #category : #'*Toplo' }
BlElement >> setTokenNamed: aSymbol value: anObject [

	self toStyleStore addTokenProperty: (aSymbol -> anObject) asTokenProperty 
]

{ #category : #'*Toplo' }
BlElement >> setUpForTheme: aTheme [

	self skinManager setUpForTheme: aTheme in: self
]

{ #category : #'*Toplo' }
BlElement >> skinInstaller [

	^ self skinManager skinInstaller 
]

{ #category : #'*Toplo' }
BlElement >> skinInstaller: aSkinInstaller [

	self skinManager skinInstaller: aSkinInstaller in: self
]

{ #category : #'*Toplo' }
BlElement >> skinManager [

	^ self userData at: #skinManager ifAbsentPut:  [ ToSkinManager new onInstalledIn: self; yourself]
]

{ #category : #'*Toplo' }
BlElement >> skinStateGeneratorClass [

	^ ToSkinStateGenerator 
]

{ #category : #'*Toplo' }
BlElement >> skinStateQueue [

	^ self skinManager skinStateQueue
]

{ #category : #'*Toplo' }
BlElement >> skinUninstaller [

	^ self skinManager skinUninstaller 
]

{ #category : #'*Toplo' }
BlElement >> skinUninstaller: aSkinUninstaller [

	self skinManager skinUninstaller: aSkinUninstaller in: self
]

{ #category : #'*Toplo' }
BlElement >> stampValueNamed: aSymbol [

	^ self toStyleStore stampValue: aSymbol
]

{ #category : #'*Toplo' }
BlElement >> stillHoveredStartDelay [

	^ self userData at: #stillHoveredStartDelay ifAbsent: [ ]
]

{ #category : #'*Toplo' }
BlElement >> stillHoveredStartDelay: aDuration [

	self userData at: #stillHoveredStartDelay put: aDuration asDuration
]

{ #category : #'*Toplo' }
BlElement >> stillPressedStartDelay [

	^ self userData at: #stillPressedStartDelay ifAbsent: [ ]
]

{ #category : #'*Toplo' }
BlElement >> stillPressedStartDelay: aDuration [

	self userData at: #stillPressedStartDelay put: aDuration asDuration
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> styleSheet: aStyleSheet [

	self skinManager styleSheet: aStyleSheet in: self
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> styleSheetChain [
	" return an array with all my inherited stylesheets "
	^ self skinManager styleSheetChainIn: self
]

{ #category : #'*Toplo' }
BlElement >> switchToNextCheckStateOnClick [

	" introduced here to avoid questionable condition in SinnableEventHandler for the management of the click event "
]

{ #category : #'*Toplo' }
BlElement >> textAttributesBuilder [

	^ self skinManager textAttributesBuilder
]

{ #category : #'*Toplo' }
BlElement >> toStyleStore [

	^ self userData at: #toStyleStore ifAbsentPut: [ ToStyleStore new onInstalledIn: self; yourself]
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toTheme [

	self isAttachedToSceneGraph ifFalse: [
		Error signal: 'A not attached element should not ask for its theme' ].
	^ self space toTheme
]

{ #category : #'*Toplo-LookAndFeel' }
BlElement >> toThemeChanged [

	self childrenDo: [ :c | c toThemeChanged ].
	self dispatchEvent: ToThemeChangedEvent new.
	" if i'm the space root element then take care to renew my base stylesheet "
	self parent ifNil: [
		self spaceDo: [ :sp |
			sp root == self ifTrue: [ sp renewRootStyleSheet ] ] ].
	self requestNewSkin
]

{ #category : #'*Toplo' }
BlElement >> tokenPropertyNamed: aSymbol [

	^ self toStyleStore tokenPropertyNamed: aSymbol from: self
]

{ #category : #'*Toplo' }
BlElement >> tokenValueNamed: aSymbol [

	^ self toStyleStore tokenPropertyValue: aSymbol from: self
]

{ #category : #'*Toplo' }
BlElement >> uninstallRawStyle [

]

{ #category : #'*Toplo' }
BlElement >> withoutSkin [

	self skinManager setSkin: ToNullSkin new in: self
]
