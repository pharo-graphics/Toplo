Class {
	#name : #ToAbstractCheckButtonSkin,
	#superclass : #ToAbstractButtonSkin,
	#category : #'Toplo-LookAndFeel-Theme-Skins-RadioButton'
}

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> buildTokens [	
	
	super buildTokens.
	
	self token: #checkedSize value: self builtCheckedSize.
	self token: #checkedBorder value: self builtCheckedBorder.
	self token: #checkedMargin value: self builtCheckedMargin.
	self token: #checkedBackground value: self builtCheckedBackground.
	self token: #checkedGeometry value: self builtCheckedGeometry.

	self token: #checkedBorderHover value: self builtCheckedBorderHover.
	self token: #checkedBackgroundHover value: self builtCheckedBackgroundHover.
	
	self token: #uncheckedGeometry value: self builtUncheckedGeometry.
	self token: #uncheckedSize value: self builtUncheckedSize.
	self token: #uncheckedBorder value: self builtUncheckedBorder.
	self token: #uncheckedMargin value: self builtUncheckedMargin.
	self token: #uncheckedBackground value: self builtUncheckedBackground.
	
	self token: #uncheckedBorderHover value: self builtUncheckedBorderHover.
	self token: #uncheckedBackgroundHover value: self builtUncheckedBackgroundHover.
	
	self token: #indeterminateGeometry value: self builtIndeterminateGeometry.
	self token: #indeterminateSize value: self builtIndeterminateSize.
	self token: #indeterminateBorder value: self builtIndeterminateBorder.
	self token: #indeterminateMargin value: self builtIndeterminateMargin.
	self token: #indeterminateBackground value: self builtIndeterminateBackground.
	
	self token: #indeterminateBorderHover value: self builtIndeterminateBorderHover.
	self token: #indeterminateBackgroundHover value: self builtIndeterminateBackgroundHover
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> builtCheckedBackground [

	^ self subclassResponsibility 
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> builtCheckedBackgroundHover [

	^ self subclassResponsibility 
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> builtCheckedBorder [

	^ self subclassResponsibility 
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> builtCheckedBorderHover [

	^ self subclassResponsibility
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> builtCheckedGeometry [

	^ self subclassResponsibility
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> builtCheckedMargin [

	^ self subclassResponsibility 
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> builtCheckedSize [

	^ self subclassResponsibility 
]

{ #category : #built }
ToAbstractCheckButtonSkin >> builtIndeterminateBackground [ 

	^ nil 
]

{ #category : #built }
ToAbstractCheckButtonSkin >> builtIndeterminateBackgroundHover [ 

	^ nil
]

{ #category : #built }
ToAbstractCheckButtonSkin >> builtIndeterminateBorder [ 

	^ nil
]

{ #category : #built }
ToAbstractCheckButtonSkin >> builtIndeterminateBorderHover [ 

	^ nil
]

{ #category : #built }
ToAbstractCheckButtonSkin >> builtIndeterminateGeometry [ 

	^ nil
]

{ #category : #built }
ToAbstractCheckButtonSkin >> builtIndeterminateMargin [ 

	^ nil 
]

{ #category : #built }
ToAbstractCheckButtonSkin >> builtIndeterminateSize [ 

	^ nil
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> builtUncheckedBackground [

	^ nil
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> builtUncheckedBackgroundHover [

	^ nil
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> builtUncheckedBorder [

	^ nil
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> builtUncheckedBorderHover [

	^ nil
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> builtUncheckedGeometry [

	^ nil
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> builtUncheckedMargin [

	^ nil
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> builtUncheckedSize [

	^ nil
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> checkedBackground [

	^ self token: #checkedBackground
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> checkedBackgroundHover [

	^ self token: #checkedBackgroundHover
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> checkedBorder [

	^ self token: #checkedBorder
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> checkedBorderHover [

	^ self token: #checkedBorderHover
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> checkedGeometry [

	^ self token: #checkedGeometry
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> checkedMargin [

	^ self token: #checkedMargin
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> checkedSize [

	^ self token: #checkedSize
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> indeterminateBackground [

	^ self token: #indeterminateBackground
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> indeterminateBackgroundHover [

	^ self token: #indeterminateBackgroundHover
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> indeterminateBorder [

	^ self token: #indeterminateBorder
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> indeterminateBorderHover [

	^ self token: #indeterminateBorderHover
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> indeterminateGeometry [

	^ self token: #indeterminateGeometry
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> indeterminateMargin [

	^ self token: #indeterminateMargin
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> indeterminateSize [

	^ self token: #indeterminateSize
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> uncheckedBackground [

	^ self token: #uncheckedBackground
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> uncheckedBackgroundHover [

	^ self token: #uncheckedBackgroundHover
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> uncheckedBorder [

	^ self token: #uncheckedBorder
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> uncheckedBorderHover [

	^ self token: #uncheckedBorderHover
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> uncheckedGeometry [

	^ self token: #uncheckedGeometry
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> uncheckedMargin [

	^ self token: #uncheckedMargin
]

{ #category : #'private - tokens' }
ToAbstractCheckButtonSkin >> uncheckedSize [

	^ self token: #uncheckedSize
]
