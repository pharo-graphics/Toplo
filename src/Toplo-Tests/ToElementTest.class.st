"
A ToElementTest is a test class for testing the behavior of ToElement
"
Class {
	#name : #ToElementTest,
	#superclass : #ToTestCaseWithSpace,
	#category : #'Toplo-Tests-Core'
}

{ #category : #'test initialize' }
ToElementTest >> testApplySkinInstallerOnFirstRequest [

	| e |
	e := ToElement new.
	e applySkinInstallerOnFirstRequest: false.
	space root addChild: e.
	self assert: e skinManager skinInstaller notNil.
	self assert: e skinManager installedSkin isNil.
	space applyAllSkinInstallers.
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager installedSkin notNil.

	e := ToElement new.
	e applySkinInstallerOnFirstRequest: true.
	space root addChild: e.
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager installedSkin notNil.
	space applyAllSkinInstallers.
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager installedSkin notNil
]

{ #category : #'test initialize' }
ToElementTest >> testApplySkinInstallerOnFirstRequestButWithNoEffect [

	| e |
	e := ToElement new.
	space root addChild: e.
	" asking to apply the skin installer on first request after it has been already requested has no effect.
	Indeed, the better place for a send of applySkinInstallerOnFirstRequest: is in the initialize method
	to be sure it will have an effect on the first requestInstallSkin "
	self assert: e skinManager skinRequestCount equals: 1.
	e applySkinInstallerOnFirstRequest: true.
	" have a skin installer"
	self assert: e skinManager skinInstaller notNil.
	" and to not have an installed skin -> illustrates no effect of applySkinInstallerOnFirstRequest: "
	self assert: e skinManager installedSkin isNil.
	e ensuredSkinManager requestInstallSkinIn: e.
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager installedSkin notNil
]

{ #category : #'test initialize' }
ToElementTest >> testApplySkinInstallerOnFirstRequestWithPostponedRequest [

	| e |
	e := ToElement new.
	e applySkinInstallerOnFirstRequest: true.
	e ensuredSkinManager requestInstallSkinIn: e.
	" request install skin should be posponed here "
	self assert: e skinManager hasPostponedInstallSkinHandler.
	self assert: e skinManager skinRequestCount equals: 0.
	self assert: e skinManager skinInstaller isNil.
	self assert:
		e skinManager installedSkin  isNil.
	space root addChild: e.
	self assert: e skinManager skinRequestCount > 1.
	" the skin is installed "
	self assert:
		e skinManager installedSkin  notNil.
	" but other install have been requested after the first installation :
	- by the postponed request
	- by the theme installation "
	self assert: e skinManager skinInstaller notNil.
	space applyAllSkinInstallers.
	" now all is in normal state "
	self assert: e skinManager skinInstaller isNil.
	self assert:
		e skinManager installedSkin  notNil
]

{ #category : #tests }
ToElementTest >> testCheckEventHandler [

	| e |
	e := ToElement new.
	self should: [ e checkEventHandler: ToSkinStateGenerator new ] raise: Error
]

{ #category : #'test initialize' }
ToElementTest >> testDefaultSkin [
	" check install/uninstall/initial states if defaultSkin: is used "

	| e sk sk2 |
	e := ToElement new.
	space root addChild: e.
	e defaultSkin: (sk := ToRawSkinForTest new).
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin isNil.
	e ensuredSkinManager requestInstallSkinIn: e.
	" no change "
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin isNil.
	self assert: (sk receivedCountForClass: ToInstallLookEvent) equals: 0.
	e skinManager applySkinReinstallIn: e.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin identicalTo: sk.
	self
		assert:
		(e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ])
			size
		equals: 1.
	self assert: (sk receivedCountForClass: ToInstallLookEvent) equals: 1.
	self
		assert: (sk receivedCountForClass: ToUninstallLookEvent)
		equals: 0.

	e defaultSkin: sk.
	e ensuredSkinManager requestInstallSkinIn: e.
	e skinManager applySkinReinstallIn: e.
	" no change since same skin "
	self assert: (sk receivedCountForClass: ToInstallLookEvent) equals: 1.
	self
		assert: (sk receivedCountForClass: ToUninstallLookEvent)
		equals: 0.

	self
		assert:
		(e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ])
			size
		equals: 1.

	e defaultSkin: (sk2 := ToRawSkinForTest new).
	e skinManager applySkinReinstallIn: e.

	self
		assert:
		(e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ])
			size
		equals: 1.

	self assert: (sk receivedCountForClass: ToInstallLookEvent) equals: 1.
	self
		assert: (sk receivedCountForClass: ToUninstallLookEvent)
		equals: 1.
	self
		assert: (sk2 receivedCountForClass: ToInstallLookEvent)
		equals: 1.
	self
		assert: (sk2 receivedCountForClass: ToUninstallLookEvent)
		equals: 0
]

{ #category : #'test initialize' }
ToElementTest >> testInstallNewSkinNow [

	| e skin |
	e := ToElement new.
	space root addChild: e.
	self assert: e skinManager skinInstaller notNil.
	self assert:
		e skinManager installedSkin isNil.
	space applyAllSkinInstallers.
	self assert: e skinManager skinInstaller isNil.
	self assert:
		e skinManager installedSkin notNil.
	skin := e skinManager installedSkin .
	" now request a skin installation "
	e ensuredSkinManager requestInstallSkinIn: e.
	self assert: e skinManager skinInstaller notNil.
	" apply all skin installers "
	space applyAllSkinInstallers.
	" but the installation has no effect because there is already one skin installed "
	self
		assert: e skinManager installedSkin
		identicalTo: skin.
	" now force a new skin installation "
	self installNewSkinNowIn: e.
	self
		deny: e skinManager installedSkin
		identicalTo: skin.
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager skinUninstaller isNil
]

{ #category : #'test initialize' }
ToElementTest >> testInstallNewSkinNowForANonAttachedElementShouldRaiseError [

	| e  |
	e := ToElement new.
	" now try to force a new skin installation -> error 
	because the element is not attached "
	self should: [ self installNewSkinNowIn: e ] raise: Error.

]

{ #category : #'test initialize' }
ToElementTest >> testOnAddedToParent [

	| e container |
	e := ToElement new.
	space root addChild: e.
	self assert: e isEnabled.
	e := ToElement new.
	e disable.
	space root addChild: e.
	self assert: e isDisabled.
	e := ToElement new.
	space root
		disable;
		addChild: e.
	self assert: e isDisabled.

	container := ToElement new.
	e := ToElement new.
	space root
		disable;
		addChild: container.
	container addChild: e.
	self assert: e isDisabled
]

{ #category : #'test initialize' }
ToElementTest >> testOnAddedToSceneGraph [

	| e |
	e := ToElement new.
	self assert: e skinManager skinInstaller isNil.
	space root addChild: e.
	self assert: e skinManager skinInstaller notNil.
	self assert: (e skinManager skinInstaller isKindOf: ToSkinInstaller)
]

{ #category : #'test initialize' }
ToElementTest >> testPostponeRequestSkin [
	" check install/uninstall/initial states if setSkin: is used"

	| e |
	e := ToElement new.
	e ensuredSkinManager requestInstallSkinIn: e.
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager hasPostponedInstallSkinHandler.
	space root addChild: e.
	self deny: e skinManager hasPostponedInstallSkinHandler.
	self assert: e skinManager skinInstaller notNil
]

{ #category : #'test initialize' }
ToElementTest >> testRequestSkin [

	| e |
	e := ToElement new.
	self assert: e skinManager skinInstaller isNil.
	self assert:
		e skinManager installedSkin isNil.
	self assert: e skinManager notNil.
	e ensuredSkinManager requestInstallSkinIn: e.
	self assert: e skinManager skinInstaller isNil.
	self assert:
		e skinManager installedSkin isNil.
	space root addChild: e.
	self assert: e skinManager skinInstaller notNil.
	self assert:
		e skinManager installedSkin isNil.
	space applyAllSkinInstallers.
	self assert: e skinManager skinInstaller isNil.
	self assert:
		e skinManager installedSkin notNil
]

{ #category : #'test initialize' }
ToElementTest >> testRequestSkin2 [

	| e |
	e := ToElement new.
	self assert: e skinManager skinInstaller isNil.
	self assert:
		e skinManager installedSkin isNil.
	self assert: e skinManager notNil.
	space root addChild: e.
	e ensuredSkinManager requestInstallSkinIn: e.
	self assert: e skinManager skinInstaller notNil.
	self assert:
		e skinManager installedSkin isNil.
	space applyAllSkinInstallers.
	self assert: e skinManager skinInstaller isNil.
	self assert:
		e skinManager installedSkin notNil
]

{ #category : #'test initialize' }
ToElementTest >> testSetSkin [
	" check install/uninstall/initial states if setSkin: is used"

	| e sk sk2 |
	e := ToElement new.
	space root addChild: e.
	e defaultSkin: (sk := ToRawSkinForTest new).
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin isNil.
	e ensuredSkinManager requestInstallSkinIn: e.
	" no change "
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin isNil.
	self assert: (sk receivedCountForClass: ToInstallLookEvent) equals: 0.
	e skinManager applySkinReinstallIn: e.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin identicalTo: sk.
	self assert: (sk receivedCountForClass: ToInstallLookEvent) equals: 1.
	self
		assert: (sk receivedCountForClass: ToUninstallLookEvent)
		equals: 0.

	self
		assert:
		(e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ])
			size
		equals: 1.

	" force uninstall->install->initial states "
	e skinManager setDefaultSkin: (sk := ToRawSkinForTest new) in: e.
	e skinManager applySkinReinstallIn: e.
	self
		assert: (sk receivedCountForClass: ToUninstallLookEvent)
		equals: 0.
	self assert: (sk receivedCountForClass: ToInstallLookEvent) equals: 1.

	self
		assert:
		(e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ])
			size
		equals: 1.

	e defaultSkin: (sk2 := ToRawSkinForTest new).
	e skinManager applySkinReinstallIn: e.

	self
		assert:
		(e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ])
			size
		equals: 1.

	self assert: (sk receivedCountForClass: ToInstallLookEvent) equals: 1.
	self
		assert: (sk receivedCountForClass: ToUninstallLookEvent)
		equals: 1.
	self
		assert: (sk2 receivedCountForClass: ToInstallLookEvent)
		equals: 1.
	self
		assert: (sk2 receivedCountForClass: ToUninstallLookEvent)
		equals: 0
]

{ #category : #'test initialize' }
ToElementTest >> testSkinInstallRequestCount [

	| e |
	e := ToElement new.
	self assert: e skinManager skinRequestCount equals: 0.
	e ensuredSkinManager requestInstallSkinIn: e.
	" request install skin should be posponed here "
	self assert: e skinManager hasPostponedInstallSkinHandler.
	self assert: e skinManager skinRequestCount equals: 0.
	space root addChild: e.
	self assert: e skinManager skinRequestCount equals: 1
	" several install may be requested after the first installation :
	- by the postponed request
	- by the theme installation "
]

{ #category : #'test initialize' }
ToElementTest >> testWithNullSkin [

	| e |
	e := ToElement new.
	e ensuredSkinManager requestInstallSkinIn: e.
	space root addChild: e.
	self assert: e skinManager skinInstaller notNil.
	self assert: (e skinManager skinInstaller isKindOf: ToSkinInstaller).
	e skinManager applySkinReinstallIn: e.
	self
		assert:
		(e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ])
			size
		equals: 1.

	e withNullSkin.
	self assert: (e skinManager skinToInstallIn: e) isNullSkin.

	e skinManager applySkinReinstallIn: e.
	self
		assert:
		(e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ])
			size
		equals: 1.

	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager installedSkin isNullSkin
]

{ #category : #'test initialize' }
ToElementTest >> testWithoutSkinNonContamination [
	" NullSkin is not contaminant: check if children are not impacted "

	| e child childchild |
	e := ToElement new.
	space root addChild: e.
	child := ToElement new.
	childchild := ToElement new.
	child addChild: childchild.
	e addChild: child.
	e ensuredSkinManager requestInstallSkinIn: e.
	e withNullSkin.
	" withoutSkin must be applied to the element hierarchy "
	self assert: (e skinManager skinToInstallIn: e) isNullSkin.
	self deny: (child skinManager skinToInstallIn: child) isNullSkin.
	self deny:
		(childchild skinManager skinToInstallIn: childchild) isNullSkin.

	e space applyAllSkinInstallers..

	self assert: e skinManager skinInstaller isNil.
	self assert:
		e skinManager installedSkin isNullSkin.
	self assert: child skinManager skinInstaller isNil.
	self assert:
		child skinManager installedSkin notNil.
	self assert: childchild skinManager skinInstaller isNil.
	self assert:
		(childchild skinManager installedSkin) notNil
]

{ #category : #'test initialize' }
ToElementTest >> testWithoutSkinNonContamination2 [
	" check if children are correctly impacted when they are added as child of their parent 
	(withoutSkin must be applied when a child is added )"

	| e child childchild |
	e := ToElement new.
	space root addChild: e.
	child := ToElement new.
	childchild := ToElement new.
	child addChild: childchild.
	e ensuredSkinManager requestInstallSkinIn: e.
	e withNullSkin.
	self assert: (e skinManager skinToInstallIn: e) isNullSkin.
	self assert: e skinManager installedSkin isNil.
	self assert: childchild skinManager installedSkin isNil.
	e skinManager applySkinReinstallIn: e.
	self assert: e skinManager skinInstaller isNil.
	self assert: e skinManager installedSkin isNullSkin.
	e addChild: child.
	e space applyAllSkinInstallers.
	self assert: child skinManager skinInstaller isNil.
	self assert: child skinManager installedSkin notNil.
	self assert: childchild skinManager skinInstaller isNil.
	self assert: childchild skinManager installedSkin notNil
]
