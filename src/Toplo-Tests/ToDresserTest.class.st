"
A ToDresserTest is a test class for testing the behavior of ToDresser
"
Class {
	#name : #ToDresserTest,
	#superclass : #ToTestCase,
	#category : #'Toplo-Tests-Dresser'
}

{ #category : #tests }
ToDresserTest >> testInstallOnlyOnce [

	| widget d0 d1 d1cpt |
	widget := ToWidget new.
	d0 := widget dresser.
	self assert: d0 isInstalled.
	d1cpt := 0.
	d1 := ToActionDresser new installAction: [ :e | d1cpt := d1cpt + 1 ].

	widget addDresser: d1.
	self assert: d1 isInstalled.
	self assert: d1cpt equals: 1.
	
	widget addDresser: d1.
	self assert: d1 isInstalled.
	self assert: d1cpt equals: 1.

]

{ #category : #tests }
ToDresserTest >> testInstalled [

	| widget d0 d1 d2 d1cpt d2cpt d3cpt d3 |
	widget := ToWidget new.
	d0 := widget dresser.
	d1cpt := 0.
	d2cpt := 0.
	d3cpt := 0.
	d1 := ToActionDresser new installAction: [ :e | d1cpt := d1cpt + 1 ]; uninstallAction: [ :e | d1cpt := d1cpt - 1 ].
	d2 := ToActionDresser new installAction: [ :e | d2cpt := d2cpt + 1 ]; uninstallAction: [ :e | d2cpt := d2cpt - 1 ].
	d3 := ToActionDresser new installAction: [ :e | d3cpt := d3cpt + 1 ]; uninstallAction: [ :e | d3cpt := d3cpt - 1 ].

	widget addDresser: d1.
	widget addDresser: d2.
	widget addDresser: d3.
	self assert: d1 isInstalled.
	self assert: d2 isInstalled.
	self assert: d3 isInstalled.
	self assert: d1cpt equals: 1.
	self assert: d2cpt equals: 1.
	self assert: d3cpt equals: 1.

]

{ #category : #tests }
ToDresserTest >> testToWidgetWithNullDresser [
	| widget d1 d2 |
	widget := ToWidget new.
	self assert: (widget dresser isKindOf: ToNullDresser).
	self assert: (widget dresser isInstalled).
	d1 := widget dresser.
	d2 := ToNullDresser new.
	widget addDresser: d2.
	self assert: widget dresser identicalTo: d2
	
]

{ #category : #tests }
ToDresserTest >> testToWidgetWithThreeDressers [
	| widget d1 d2 d3 |
	widget := ToWidget new.
	d1 := widget dresser.
	d2 := ToActionDresser new.
	widget addDresser: d2.
	self assert: widget dresser identicalTo: d2.
	self assert: d2 next identicalTo: d1.
	d3 := ToActionDresser new.
	widget addDresser: d3.
	self assert: widget dresser identicalTo: d2.
	self assert: d2 next identicalTo: d3.
	self assert: d3 next identicalTo: d1

		
]

{ #category : #tests }
ToDresserTest >> testToWidgetWithTwoDresser [
	| widget d1 d2 |
	widget := ToWidget new.
	d1 := widget dresser.

	d2 := ToActionDresser new.
	widget addDresser: d2.
	self assert: widget dresser identicalTo: d2.
	self assert: d2 next identicalTo: d1.
	self assert: widget dresser identicalTo: d2.
	self assert: d2 next identicalTo: d1.

	
]

{ #category : #tests }
ToDresserTest >> testUninstalled1 [

	| widget d0 d1 d2 d1cpt d2cpt d3cpt d3 |
	widget := ToWidget new.
	d0 := widget dresser.
	d1cpt := 0.
	d2cpt := 0.
	d3cpt := 0.
	d1 := ToActionDresser new installAction: [ :e | d1cpt := d1cpt + 1 ]; uninstallAction: [ :e | d1cpt := d1cpt - 1 ].
	d2 := ToActionDresser new installAction: [ :e | d2cpt := d2cpt + 1 ]; uninstallAction: [ :e | d2cpt := d2cpt - 1 ].
	d3 := ToActionDresser new installAction: [ :e | d3cpt := d3cpt + 1 ]; uninstallAction: [ :e | d3cpt := d3cpt - 1 ].

	widget addDresser: d1.
	widget addDresser: d2.
	widget addDresser: d3.
	widget removeDresser: d1.
	self assert: d1 isInstalled not.
	self assert: d2 isInstalled.
	self assert: d3 isInstalled.
	self assert: d1cpt equals: 0.
	self assert: d2cpt equals: 1.
	self assert: d3cpt equals: 1.

]

{ #category : #tests }
ToDresserTest >> testUninstalled2 [

	| widget d0 d1 d2 d1cpt d2cpt d3cpt d3 |
	widget := ToWidget new.
	d0 := widget dresser.
	d1cpt := 0.
	d2cpt := 0.
	d3cpt := 0.
	d1 := ToActionDresser new installAction: [ :e | d1cpt := d1cpt + 1 ]; uninstallAction: [ :e | d1cpt := d1cpt - 1 ].
	d2 := ToActionDresser new installAction: [ :e | d2cpt := d2cpt + 1 ]; uninstallAction: [ :e | d2cpt := d2cpt - 1 ].
	d3 := ToActionDresser new installAction: [ :e | d3cpt := d3cpt + 1 ]; uninstallAction: [ :e | d3cpt := d3cpt - 1 ].

	widget addDresser: d1.
	widget addDresser: d2.
	widget addDresser: d3.
	widget removeDresser: d2.
	self assert: d1 isInstalled.
	self assert: d2 isInstalled not.
	self assert: d3 isInstalled.
	self assert: d1cpt equals: 1.
	self assert: d2cpt equals: 0.
	self assert: d3cpt equals: 1.

]

{ #category : #tests }
ToDresserTest >> testUninstalled3 [

	| widget d0 d1 d2 d1cpt d2cpt d3cpt d3 |
	widget := ToWidget new.
	d0 := widget dresser.
	d1cpt := 0.
	d2cpt := 0.
	d3cpt := 0.
	d1 := ToActionDresser new installAction: [ :e | d1cpt := d1cpt + 1 ]; uninstallAction: [ :e | d1cpt := d1cpt - 1 ].
	d2 := ToActionDresser new installAction: [ :e | d2cpt := d2cpt + 1 ]; uninstallAction: [ :e | d2cpt := d2cpt - 1 ].
	d3 := ToActionDresser new installAction: [ :e | d3cpt := d3cpt + 1 ]; uninstallAction: [ :e | d3cpt := d3cpt - 1 ].

	widget addDresser: d1.
	widget addDresser: d2.
	widget addDresser: d3.
	widget removeDresser: d3.
	self assert: d1 isInstalled.
	self assert: d2 isInstalled.
	self assert: d3 isInstalled  not.
	self assert: d1cpt equals: 1.
	self assert: d2cpt equals: 1.
	self assert: d3cpt equals: 0.

]

{ #category : #tests }
ToDresserTest >> testUninstalled4 [

	| widget d0 d1 d2 d1cpt d2cpt d3cpt d3 |
	widget := ToWidget new.
	d0 := widget dresser.
	d1cpt := 0.
	d2cpt := 0.
	d3cpt := 0.
	d1 := ToActionDresser new installAction: [ :e | d1cpt := d1cpt + 1 ]; uninstallAction: [ :e | d1cpt := d1cpt - 1 ].
	d2 := ToActionDresser new installAction: [ :e | d2cpt := d2cpt + 1 ]; uninstallAction: [ :e | d2cpt := d2cpt - 1 ].
	d3 := ToActionDresser new installAction: [ :e | d3cpt := d3cpt + 1 ]; uninstallAction: [ :e | d3cpt := d3cpt - 1 ].

	widget addDresser: d1.
	widget addDresser: d2.
	widget addDresser: d3.
	widget removeDresser: d3.
	widget removeDresser: d1.
	self assert: d1 isInstalled not.
	self assert: d2 isInstalled.
	self assert: d3 isInstalled  not.
	self assert: d1cpt equals: 0.
	self assert: d2cpt equals: 1.
	self assert: d3cpt equals: 0.
	self assert: widget dresser identicalTo: d2

]

{ #category : #tests }
ToDresserTest >> testUninstalled5 [

	| widget d0 d1 d2 d1cpt d2cpt d3cpt d3 |
	widget := ToWidget new.
	d0 := widget dresser.
	d1cpt := 0.
	d2cpt := 0.
	d3cpt := 0.
	d1 := ToActionDresser new installAction: [ :e | d1cpt := d1cpt + 1 ]; uninstallAction: [ :e | d1cpt := d1cpt - 1 ].
	d2 := ToActionDresser new installAction: [ :e | d2cpt := d2cpt + 1 ]; uninstallAction: [ :e | d2cpt := d2cpt - 1 ].
	d3 := ToActionDresser new installAction: [ :e | d3cpt := d3cpt + 1 ]; uninstallAction: [ :e | d3cpt := d3cpt - 1 ].

	widget addDresser: d1.
	widget addDresser: d2.
	widget addDresser: d3.
	widget removeDresser: d3.
	widget removeDresser: d1.
	widget removeDresser: d2.
	self assert: d1 isInstalled not.
	self assert: d2 isInstalled not.
	self assert: d3 isInstalled  not.
	self assert: d1cpt equals: 0.
	self assert: d2cpt equals: 0.
	self assert: d3cpt equals: 0.
	self assert: (widget dresser isKindOf: ToNullDresser)

]
