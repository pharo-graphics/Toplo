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
	space root addChild: e.
	self deny: e skinManager newSkinRequested.
	self assert: e skinManager installedSkin isThemeSkin.
	space applyAllSkinInstallers.
	self deny: e skinManager newSkinRequested.
	self assert: e skinManager installedSkin isThemeSkin
]

{ #category : #'test initialize' }
ToElementTest >> testApplySkinInstallerOnFirstRequestButWithNoEffect [

	| e |
	e := ToElement new.
	space root addChild: e.
	" the skin installer is not immediately applied after it has been already requested. "
	" no skin installer anymore "
	self deny: e skinManager newSkinRequested.
	" and to not have an installed skin -> illustrates no effect of applySkinInstallerOnFirstRequest: "
	self assert: e skinManager installedSkin isThemeSkin.
	e ensuredSkinManager requestNewSkinIn: e.
	self assert: e skinManager newSkinRequested.
	self assert: e skinManager installedSkin isThemeSkin
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
	self assert: e skinManager installedSkin isThemeSkin.
	e ensuredSkinManager requestNewSkinIn: e.
	" no change "
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin isThemeSkin.
	self assert: (sk receivedCountForClass: ToInstallSkinEvent) equals: 0.
	e skinManager installNewSkinIn: e.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin identicalTo: sk.
	self
		assert:
		(e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ])
			size
		equals: 1.
	self assert: (sk receivedCountForClass: ToInstallSkinEvent) equals: 1.
	self
		assert: (sk receivedCountForClass: ToUninstallSkinEvent)
		equals: 0.

	e defaultSkin: sk.
	e ensuredSkinManager requestNewSkinIn: e.
	self assert: (sk receivedCountForClass: ToInstallSkinEvent) equals: 1.
	self
		assert: (sk receivedCountForClass: ToUninstallSkinEvent)
		equals: 0.

	self
		assert:
		(e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ])
			size
		equals: 1.

	e defaultSkin: (sk2 := ToRawSkinForTest new).
	e skinManager installNewSkinIn: e.

	self
		assert:
		(e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ])
			size
		equals: 1.

	self assert: (sk receivedCountForClass: ToInstallSkinEvent) equals: 1.
	self
		assert: (sk receivedCountForClass: ToUninstallSkinEvent)
		equals: 1.
	self
		assert: (sk2 receivedCountForClass: ToInstallSkinEvent)
		equals: 1.
	self
		assert: (sk2 receivedCountForClass: ToUninstallSkinEvent)
		equals: 0
]

{ #category : #'test initialize' }
ToElementTest >> testInstallNewSkinNow [

	| e skin |
	e := ToElementForRawSkinTest new.
	space root addChild: e.
	self deny: e skinManager newSkinRequested.
	self assert:
		e skinManager installedSkin isThemeSkin.
	space applyAllSkinInstallers.
	self deny: e skinManager newSkinRequested.
	self assert:
		e skinManager installedSkin isThemeSkin.
	skin := e skinManager installedSkin .
	" now request a skin installation "
	e ensuredSkinManager requestNewSkinIn: e.
	self assert: e skinManager newSkinRequested.
	" apply all skin installers "
	space applyAllSkinInstallers.
	" but the installation has no effect because there is already one skin installed "
	self
		assert: e skinManager installedSkin isThemeSkin.
	" now force a new skin installation "
	self installNewSkinNowIn: e.
	self
		deny: e skinManager installedSkin
		identicalTo: skin.
	self deny: e skinManager newSkinRequested
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
	self deny: e skinManager newSkinRequested.
	space root addChild: e.
	self deny: e skinManager newSkinRequested.
	self assert: e skinManager installedSkin isThemeSkin
]

{ #category : #'test initialize' }
ToElementTest >> testRequestSkin [

	| e |
	e := ToElement new.
	self deny: e skinManager newSkinRequested.
	self assert:
		e skinManager installedSkin isUnknownSkin.
	e ensuredSkinManager requestNewSkinIn: e.
	self assert: e skinManager newSkinRequested.
	self assert:
		e skinManager installedSkin isUnknownSkin.
	space root addChild: e.
	self deny: e skinManager newSkinRequested.
	self assert:
		e skinManager installedSkin isThemeSkin.
	space applyAllSkinInstallers.
	self deny: e skinManager newSkinRequested.
	self assert:
		e skinManager installedSkin isThemeSkin
]

{ #category : #'test initialize' }
ToElementTest >> testRequestSkin2 [

	| e |
	e := ToElement new.
	self deny: e skinManager newSkinRequested.
	self deny:
		e skinManager installedSkin isThemeSkin.
	space root addChild: e.
	e ensuredSkinManager requestNewSkinIn: e.
	self assert: e skinManager newSkinRequested.
	self assert:
		e skinManager installedSkin isThemeSkin.
	space applyAllSkinInstallers.
	self deny: e skinManager newSkinRequested.
	self assert:
		e skinManager installedSkin isThemeSkin
]

{ #category : #'test initialize' }
ToElementTest >> testSetSkin [
	" check install/uninstall/initial states if setSkin: is used"

	| e sk sk2 |
	e := ToElement new.
	space root addChild: e.
	e defaultSkin: (sk := ToRawSkinForTest new).
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin isThemeSkin.
	e ensuredSkinManager requestNewSkinIn: e.
	" no change "
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin isThemeSkin.
	self assert: (sk receivedCountForClass: ToInstallSkinEvent) equals: 0.
	e skinManager installNewSkinIn: e.
	self assert: (e skinManager skinToInstallIn: e) identicalTo: sk.
	self assert: e skinManager installedSkin identicalTo: sk.
	self assert: (sk receivedCountForClass: ToInstallSkinEvent) equals: 1.
	self
		assert: (sk receivedCountForClass: ToUninstallSkinEvent)
		equals: 0.

	self
		assert:
		(e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ])
			size
		equals: 1.

	" force uninstall->install->initial states "
	e defaultSkin: (sk := ToRawSkinForTest new).
	e skinManager installNewSkinIn: e.
	self
		assert: (sk receivedCountForClass: ToUninstallSkinEvent)
		equals: 0.
	self assert: (sk receivedCountForClass: ToInstallSkinEvent) equals: 1.

	self
		assert:
		(e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ])
			size
		equals: 1.

	e defaultSkin: (sk2 := ToRawSkinForTest new).
	e skinManager installNewSkinIn: e.

	self
		assert:
		(e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ])
			size
		equals: 1.

	self assert: (sk receivedCountForClass: ToInstallSkinEvent) equals: 1.
	self
		assert: (sk receivedCountForClass: ToUninstallSkinEvent)
		equals: 1.
	self
		assert: (sk2 receivedCountForClass: ToInstallSkinEvent)
		equals: 1.
	self
		assert: (sk2 receivedCountForClass: ToUninstallSkinEvent)
		equals: 0
]

{ #category : #'test initialize' }
ToElementTest >> testSkinInstallRequestCount [

	| e |
	e := ToElement new.
	self assert: e skinManager installedSkin isUnknownSkin.
	e ensuredSkinManager requestNewSkinIn: e.
	self assert: e skinManager installedSkin isUnknownSkin.
	space root addChild: e.
	self deny: e skinManager installedSkin isUnknownSkin
]

{ #category : #'test initialize' }
ToElementTest >> testWithNullSkin [

	| e |
	e := ToElement new.
	e ensuredSkinManager requestNewSkinIn: e.
	space root addChild: e.
	self deny: e skinManager newSkinRequested.
	e skinManager installNewSkinIn: e.
	self
		assert:
		(e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ])
			size
		equals: 1.

	e withNullSkin.
	self assert: (e skinManager skinToInstallIn: e) isNullSkin.

	e skinManager installNewSkinIn: e.
	self
		assert:
		(e eventDispatcher handlers select: [ :h | h isKindOf: ToSkin ])
			size
		equals: 1.

	self deny: e skinManager newSkinRequested.
	self assert: e skinManager installedSkin isNullSkin
]

{ #category : #'test initialize' }
ToElementTest >> testWithoutSkinNonContamination [
	" NullSkin is not contaminant: check if children are not impacted "

	| e child childchild |
	e := ToElement new.
	e defaultSkin: ToRawSkin new.
	space root addChild: e.
	child := ToElement new.
	child defaultSkin: ToRawSkin new.
	childchild := ToElement new.
	childchild defaultSkin: ToRawSkin new.
	child addChild: childchild.
	e addChild: child.
	e ensuredSkinManager requestNewSkinIn: e.
	e withNullSkin.
	" withoutSkin must be applied to the element hierarchy "
	self assert: (e skinManager skinToInstallIn: e) isNullSkin.
	self deny: (child skinManager skinToInstallIn: child) isNullSkin.
	self deny:
		(childchild skinManager skinToInstallIn: childchild) isNullSkin.

	e space applyAllSkinInstallers.

	self deny: e skinManager newSkinRequested.
	self assert: e skinManager installedSkin isNullSkin.
	self deny: child skinManager newSkinRequested.
	self assert: child skinManager installedSkin notNil.
	self deny: childchild skinManager newSkinRequested.
	self assert: childchild skinManager installedSkin notNil
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
	e withNullSkin.
	e ensuredSkinManager requestNewSkinIn: e.
	self assert: (e skinManager skinToInstallIn: e) isNullSkin.
	self assert: e skinManager installedSkin isThemeSkin.
	self deny: childchild skinManager installedSkin isThemeSkin.
	e skinManager installNewSkinIn: e.
	self deny: e skinManager newSkinRequested.
	self assert: e skinManager installedSkin isNullSkin.
	e addChild: child.
	e space applyAllSkinInstallers.
	self deny: child skinManager newSkinRequested.
	self assert: child skinManager installedSkin isThemeSkin.
	self deny: childchild skinManager newSkinRequested.
	self assert: childchild skinManager installedSkin isThemeSkin
]
