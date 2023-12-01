Class {
	#name : 'ToRawSkinForTest',
	#superclass : 'ToRawSkin',
	#instVars : [
		'initialCpt',
		'installCpt',
		'uninstallCpt'
	],
	#category : 'Toplo-Tests-Core',
	#package : 'Toplo-Tests',
	#tag : 'Core'
}

{ #category : 'accessing' }
ToRawSkinForTest >> initialCpt [

	^ initialCpt
]

{ #category : 'initialization' }
ToRawSkinForTest >> initialize [ 

	super initialize.
	initialCpt := 0.
	installCpt := 0.
	uninstallCpt := 0
]

{ #category : 'accessing' }
ToRawSkinForTest >> installCpt [

	^ installCpt
]

{ #category : 'event handling' }
ToRawSkinForTest >> installLookEvent: anEvent [

	installCpt := installCpt + 1.
	initialCpt := initialCpt + 1
]

{ #category : 'accessing' }
ToRawSkinForTest >> uninstallCpt [

	^ uninstallCpt
]

{ #category : 'event handling' }
ToRawSkinForTest >> uninstallLookEvent: anEvent [

	uninstallCpt := uninstallCpt + 1
]
