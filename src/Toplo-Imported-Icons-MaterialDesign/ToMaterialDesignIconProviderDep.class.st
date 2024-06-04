"
(ToImportedIconProvider listElementWithAllIconsInProviderClass: ToMaterialDesignAlertIconProvider ) openInSpace.
(ToImportedIconProvider listElementWithAllIconsInProviderClass: ToMaterialDesignCommunicationIconProvider ) openInSpace.
(ToImportedIconProvider listElementWithAllIconsInProviderClass: ToMaterialDesignContentIconProvider ) openInSpace.
(ToImportedIconProvider listElementWithAllIconsInProviderClass: ToMaterialDesignMapsIconProvider ) openInSpace.

(ToIconSharpStyle iconNamed: '18mp' inProvider: ToMaterialDesignImageIconProvider) matchParent; openInSpace.
(ToIconFilledStyle iconNamed: 'argiculture' inProvider: ToMaterialDesignImageIconProvider) matchParent; openInSpace.
"
Class {
	#name : #ToMaterialDesignIconProviderDep,
	#superclass : #ToImportedIconProvider,
	#category : #'Toplo-Imported-Icons-MaterialDesign'
}

{ #category : #'_private - icon type' }
ToMaterialDesignIconProviderDep class >> _iconType [
	^ self subclassResponsibility
]

{ #category : #'_private - loaded and unloadable' }
ToMaterialDesignIconProviderDep class >> _outlined_loaded [
	^ self subclassResponsibility
]

{ #category : #'_private - loaded and unloadable' }
ToMaterialDesignIconProviderDep class >> _outlined_unloadable [
	^ self subclassResponsibility
]

{ #category : #'_private - loaded and unloadable' }
ToMaterialDesignIconProviderDep class >> _round_loaded [
	^ self subclassResponsibility
]

{ #category : #'_private - loaded and unloadable' }
ToMaterialDesignIconProviderDep class >> _round_unloadable [
	^ self subclassResponsibility
]

{ #category : #'_private - loaded and unloadable' }
ToMaterialDesignIconProviderDep class >> _sharp_loaded [
	^ self subclassResponsibility
]

{ #category : #'_private - loaded and unloadable' }
ToMaterialDesignIconProviderDep class >> _sharp_unloadable [
	^ self subclassResponsibility
]

{ #category : #'_private - loaded and unloadable' }
ToMaterialDesignIconProviderDep class >> _twotone_loaded [
	^ self subclassResponsibility
]

{ #category : #'_private - loaded and unloadable' }
ToMaterialDesignIconProviderDep class >> _twotone_unloadable [
	^ self subclassResponsibility
]
