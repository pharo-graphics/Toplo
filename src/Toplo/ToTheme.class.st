Class {
	#name : #ToTheme,
	#superclass : #Object,
	#instVars : [
		'icons',
		'tokenProperties'
	],
	#category : #'Toplo-Core-Theme'
}

{ #category : #testing }
ToTheme class >> canBeDefault [

	^ false
]

{ #category : #accessing }
ToTheme class >> defaultCheckboxHeight [

	^ 20
]

{ #category : #accessing }
ToTheme class >> defaultColorPrimary [

	^ Color fromHexString: '#1677ff'
]

{ #category : #accessing }
ToTheme class >> defaultSwitchIconHeight [

	^ 16
]

{ #category : #accessing }
ToTheme class >> defaultTokenProperties [
	" skin managing need a list of unique stamps . "

	^ {
		  (ToTokenProperty
			   name: #'sh-style-table'
			   value: SHRBTextStyler defaultStyleTable).
		  (ToTokenProperty name: #'background-color' value: Color white).
		  (ToTokenProperty
			   name: #empty_box
			   value: (ToMiscellaneousIcons innerImageNamed: 'filled_emptyBox')).
		  (ToTokenProperty
			   name: #'check'
			   value: (ToMaterialDesignIconProvider innerImageNamed:
					    'outlined_check')).

		  (ToTokenProperty
			   name: #'iconic-arrow-right'
			   value: (ToMaterialDesignIconProvider innerImageNamed:
					    'outlined_keyboardarrowright')).
		  (ToTokenProperty
			   name: #'iconic-arrow-left'
			   value: (ToMaterialDesignIconProvider innerImageNamed:
					    'outlined_keyboardarrowleft')).
		  (ToTokenProperty
			   name: #'iconic-arrow-down'
			   value: (ToMaterialDesignIconProvider innerImageNamed:
					    'outlined_keyboardarrowdown')).
		  (ToTokenProperty
			   name: #'iconic-arrow-up'
			   value: (ToMaterialDesignIconProvider innerImageNamed:
					    'outlined_keyboardarrowup')).

		(ToTokenProperty
			   name: #'iconic-arrow-breadth'
			   value: 18).
		(ToTokenProperty
			   name: #'node-indent'
			   value: 18).
		(ToTokenProperty
			   name: #'node-interspace'
			   value: 8).
		  (ToTokenProperty name: #'border-radius' value: 4).
		  (ToTokenProperty name: #'border-radius-LG' value: 8).
		  (ToTokenProperty name: #'border-radius-SM' value: 4).

		  (ToTokenProperty
			   name: #'animation-window-opening'
			   value: [ :win |
				   win opacity: 0.1.
				   win addAnimation:
					   ((BlOpacityAnimation new opacity: 1.9) duration:
						    500 milliSeconds) ]).

		  (ToTokenProperty
			   name: #'effect-window'
			   value: (BlGaussianShadowEffect
					    color: (Color veryLightGray alpha: 0.5)
					    width: 20
					    offset: 0 @ 4)).

		  (ToTokenProperty
			   name: #'effect-window-menu'
			   value: (BlGaussianShadowEffect
					    color: Color lightGray
					    width: 15
					    offset: 0 asPoint)).

		  (ToTokenProperty
			   name: #'color-bg-container'
			   value: (Color fromHexString: '#ffffff')).
		  (ToTokenProperty
			   name: #'color-bg-container-disabled'
			   value: (Color black alpha: 0.04)).
		  (ToTokenProperty name: #'color-bg-tooltip' value: Color white).
		  (ToTokenProperty
			   name: #'color-bg-text-active'
			   value: (Color black alpha: 0.15)).
		  (ToTokenProperty
			   name: #'color-bg-text-hover'
			   value: (Color black alpha: 0.2)).
		  (ToTokenProperty
			   name: #'color-border'
			   value: (Color fromHexString: '#d9d9d9')).
		  (ToTokenProperty
			   name: #'color-border-checkable'
			   value: Color transparent).
		  (ToTokenProperty
			   name: #'color-border-disabled'
			   value: (Color veryLightGray alpha: 0.2)).
		  (ToTokenProperty
			   name: #'color-border-indeterminate'
			   value: self defaultColorPrimary lighter).
		  (ToTokenProperty
			   name: #'color-error-bg'
			   value: (Color fromHexString: '#fff2f0')).
		  (ToTokenProperty
			   name: #'color-error-hover'
			   value: (Color fromHexString: '#ff7875')).
		  (ToTokenProperty
			   name: #'color-error-pressed'
			   value: (Color fromHexString: '#e75c5d')).
		  (ToTokenProperty
			   name: #'color-error'
			   value: (Color fromHexString: '#ff4d4f')).
		  (ToTokenProperty
			   name: #'color-image-disabled'
			   value: (Color black alpha: 1.0)).
		  (ToTokenProperty
			   name: #'color-image-light-solid'
			   value: (Color fromHexString: '#ffffff')).

		  (ToTokenProperty
			   name: #'color-link'
			   value: (Color fromHexString: '#1677ff')).
		  (ToTokenProperty
			   name: #'color-link-active'
			   value: (Color fromHexString: '#0958d9')).
		  (ToTokenProperty
			   name: #'color-link-hover'
			   value: (Color fromHexString: '#69b1ff')).

		  (ToTokenProperty
			   name: #'color-primary'
			   value: self defaultColorPrimary).
		  (ToTokenProperty
			   name: #'color-primary-pressed'
			   value: self defaultColorPrimary darker darker).
		  (ToTokenProperty
			   name: #'color-primary-checked'
			   value: self defaultColorPrimary).
		  (ToTokenProperty
			   name: #'text-color-primary-checked'
			   value: Color white).
		  (ToTokenProperty
			   name: #'color-primary-unchecked'
			   value: (Color fromHexString: '#ffffff')).
		  (ToTokenProperty
			   name: #'color-primary-indeterminate'
			   value: (self defaultColorPrimary alpha: 0.5)).
		  (ToTokenProperty
			   name: #'color-primary-hover'
			   value: (self defaultColorPrimary alpha: 0.1)).

		  (ToTokenProperty
			   name: #'color-success'
			   value: (Color fromHexString: '#52c41a')).
		  (ToTokenProperty
			   name: #'color-warning'
			   value: (Color fromHexString: '#faad14')).

		  (ToTokenProperty name: #'color-text' value: Color black).
		(ToTokenProperty name: #'color-text-placeholder' value: Color lightGray).
		  (ToTokenProperty
			   name: #'color-text-description'
			   value: (Color black alpha: 0.45)).
		  (ToTokenProperty
			   name: #'color-text-disabled'
			   value: (Color lightGray alpha: 0.6)).
		  (ToTokenProperty
			   name: #'color-text-heading'
			   value: (Color black alpha: 0.88)).
		  (ToTokenProperty
			   name: #'color-text-light-solid'
			   value: (Color fromHexString: '#ffffff')).
		  (ToTokenProperty
			   name: #'color-text-secondary'
			   value: (Color black alpha: 0.45)).
		  (ToTokenProperty
			   name: #'selected-focused-foreground'
			   value: Color white).
		  (ToTokenProperty
			   name: #'selected-unfocused-foreground'
			   value: self defaultColorPrimary).
		  (ToTokenProperty
			   name: #'text-foreground-in-tooltip'
			   value: (Color fromHexString: '#313339')).

		  (ToTokenProperty name: #'dash-array' value: #( 3 3 )).

		  "#( 'SFMono-Regular' , Consolas , 'Liberation Mono', Menlo , Courier , monospace )"
		  (ToTokenProperty name: #'font-family-code' value: 'Courier').
		  (ToTokenProperty name: #'font-size' value: 14).
		  (ToTokenProperty name: #'font-size-in-tooltip' value: 12).
		  (ToTokenProperty name: #'font-size-H1' value: 38).
		  (ToTokenProperty name: #'font-size-H2' value: 30).
		  (ToTokenProperty name: #'font-size-H3' value: 24).
		  (ToTokenProperty name: #'font-size-H4' value: 20).
		  (ToTokenProperty name: #'font-size-H5' value: 16).
		  (ToTokenProperty name: #'font-weight-strong' value: 600).

		  (ToTokenProperty name: #'line-height' value: 1).
		  (ToTokenProperty name: #'line-height-H1' value: 1.2).
		  (ToTokenProperty name: #'line-height-H2' value: 1.3).
		  (ToTokenProperty name: #'line-height-H3' value: 1.3).
		  (ToTokenProperty name: #'line-height-H4' value: 1.4).
		  (ToTokenProperty name: #'line-height-H5' value: 1.5).

		  (ToTokenProperty name: #'line-type' value: #solid).
		  (ToTokenProperty name: #'line-width' value: 1).
		  (ToTokenProperty name: #'focus-border-width' value: 2).
		  (ToTokenProperty
			   name: #'focus-border-paint'
			   value: self defaultColorPrimary).
		  (ToTokenProperty name: #'border-width' value: 1).
		  (ToTokenProperty name: #'border-paint' value: (Color veryLightGray alpha: 0.2)).

		  "Size, margin and padding"
		  (ToTokenProperty name: #'control-height' value: 32).
		  (ToTokenProperty name: #'control-height-LG' value: 40).
		  (ToTokenProperty name: #'control-height-SM' value: 24).

		  (ToTokenProperty name: #'margin-XS' value: 8).

		  (ToTokenProperty name: #'padding-iconic-button' value: 1).
		  (ToTokenProperty name: #'padding-content-H' value: 12).
		  (ToTokenProperty name: #'padding-content-HS' value: 4).
		  (ToTokenProperty name: #'padding-content-HXS' value: 2).
		  (ToTokenProperty name: #'padding-content-V' value: 6).
		  (ToTokenProperty name: #'padding-content-VS' value: 4).
		  (ToTokenProperty name: #'padding-content-VXS' value: 2).
		  (ToTokenProperty name: #'padding-S' value: 14).
		  (ToTokenProperty name: #'padding-XS' value: 8).
		  (ToTokenProperty name: #'padding-XXS' value: 3).

		  (ToTokenProperty name: #'button-interspace' value: 8).
		  (ToTokenProperty name: #'list-padding-H' value: 6).
		  (ToTokenProperty name: #'list-padding-V' value: 6).
		  (ToTokenProperty name: #'list-node-padding-H' value: 2).
		  (ToTokenProperty name: #'list-node-padding-V' value: 2).
		  (ToTokenProperty name: #'bar-node-padding-H' value: 3).
		  (ToTokenProperty name: #'bar-node-padding-V' value: 2).
		  (ToTokenProperty name: #'menu-node-padding-H' value: 6).
		  (ToTokenProperty name: #'menu-node-padding-V' value: 2).
		  (ToTokenProperty name: #'menu-item-padding-H' value: 6).
		  (ToTokenProperty name: #'menu-item-padding-V' value: 1).
		  (ToTokenProperty name: #'menu-window-padding-H' value: 8).
		  (ToTokenProperty name: #'menu-window-padding-V' value: 8).
		  (ToTokenProperty name: #'segmented-node-padding-H' value: 0).
		  (ToTokenProperty name: #'segmented-node-padding-V' value: 0).
		  (ToTokenProperty name: #'segmented-border-radius' value: 12).
		  (ToTokenProperty
			   name: #'segmented-background'
			   value: (Color veryLightGray alpha: 0.06)).


		  (ToTokenProperty
			   name: #'text-editor-background-disabled'
			   value: (Color black alpha: 0.1)).
		  (ToTokenProperty name: #'text-editor-padding-H' value: 3).
		  (ToTokenProperty name: #'text-editor-padding-V' value: 2).
		  (ToTokenProperty name: #'menu-item-start-alignment' value: 28).
		  (ToTokenProperty name: #'menu-item-end-interspace' value: 15).
		  (ToTokenProperty name: #'inline-item-gap' value: 7).
		  (ToTokenProperty
			   name: #'checkbox-checked-image'
			   value: (ToMaterialDesignIconProvider innerImageNamed:
					    'outlined_checkbox')).
		  (ToTokenProperty
			   name: #'checkbox-unchecked-image'
			   value: (ToMaterialDesignIconProvider innerImageNamed:
					    'outlined_checkboxoutlineblank')).
		  (ToTokenProperty
			   name: #'checkbox-indeterminate-image'
			   value: (ToMaterialDesignIconProvider innerImageNamed:
					    'outlined_indeterminatecheckbox')).
		  (ToTokenProperty
			   name: #'radio-checked-image'
			   value: (ToMaterialDesignIconProvider innerImageNamed:
					    'outlined_radiobuttonchecked')).
		  (ToTokenProperty
			   name: #'radio-unchecked-image'
			   value: (ToMaterialDesignIconProvider innerImageNamed:
					    'outlined_radiobuttonunchecked')).
		  (ToTokenProperty
			   name: #'switch-checked-background'
			   value: self defaultColorPrimary).
		  (ToTokenProperty
			   name: #'switch-unchecked-background'
			   value: Color lightGray).
		  (ToTokenProperty
			   name: #'switch-disabled-background'
			   value: Color lightGray).
		  (ToTokenProperty
			   name: #'switch-handle-disabled-background'
			   value: Color veryLightGray).
		  (ToTokenProperty
			   name: #'switch-handle-enabled-background'
			   value: Color white).
		  (ToTokenProperty
			   name: #'switch-icon-size'
			   value: 24 @ self defaultSwitchIconHeight).
		  (ToTokenProperty
			   name: #'checkable-icon-size'
			   value: self defaultCheckboxHeight asPoint).
		  (ToTokenProperty
			   name: #'menu-icon-size'
			   value: self defaultCheckboxHeight asPoint).
		  (ToTokenProperty
			   name: #'color-list-primary-selection-focused'
			   value: (self defaultColorPrimary)).
		  (ToTokenProperty
			   name: #'color-list-primary-selection-over-focused'
			   value: (self defaultColorPrimary alpha: 0.3)).
		  (ToTokenProperty
			   name: #'color-list-primary-selection-unfocused'
			   value: (self defaultColorPrimary alpha: 0.2)).
		  (ToTokenProperty
			   name: #'color-list-primary-selection-over-unfocused'
			   value: (self defaultColorPrimary alpha: 0.1)).

		  (ToTokenProperty
			   name: #'color-primary-selection-focused'
			   value: (self defaultColorPrimary alpha: 0.3)).
		  (ToTokenProperty
			   name: #'color-primary-selection-over-focused'
			   value: (self defaultColorPrimary alpha: 0.1)).
		  (ToTokenProperty
			   name: #'color-primary-selection-unfocused'
			   value: (self defaultColorPrimary lighter alpha: 0.1)).
		  (ToTokenProperty
			   name: #'color-primary-selection-over-unfocused'
			   value: (self defaultColorPrimary alpha: 0.05)).
		  (ToTokenProperty
			   name: #'color-primary-selection-disabled'
			   value: (Color gray alpha: 0.3)).
		  (ToTokenProperty
			   name: #'color-secondary-selection'
			   value: (Color gray alpha: 0.1)).
		  (ToTokenProperty
			   name: #'tab-color-secondary-selection'
			   value: (Color gray alpha: 0.5)).

		  (ToTokenProperty name: #'border-width-primary-selection' value: 1).
		  (ToTokenProperty
			   name: #'border-color-danger-selection'
			   value: Color red).
		  (ToTokenProperty
			   name: #'border-color-primary-selection'
			   value: self defaultColorPrimary darker).
		  (ToTokenProperty
			   name: #'list-context-menu-selection-border-gap'
			   value: 1.0) }
]

{ #category : #accessing }
ToTheme class >> label [

	^ 'Unsupported abstract theme'
]

{ #category : #accessing }
ToTheme class >> technicalTokenProperties [
	" toplo need a list of unique stamps for widget technical parameters. "

	^ {  }
]

{ #category : #accessing }
ToTheme >> addTokenNamed: aSymbol withValue: anObject [

	self addTokenProperty: (aSymbol -> anObject) asTokenProperty 
]

{ #category : #accessing }
ToTheme >> addTokenProperties: aCollection [

	tokenProperties addAll: aCollection
]

{ #category : #accessing }
ToTheme >> addTokenProperty: aTokenProperty [

	tokenProperties add: aTokenProperty
]

{ #category : #accessing }
ToTheme >> defaultSkinFor: anElement [

	^ anElement defaultSkin
]

{ #category : #accessing }
ToTheme >> defaultTokenProperties [

	^ self class defaultTokenProperties
]

{ #category : #accessing }
ToTheme >> icons [

	^ icons
]

{ #category : #accessing }
ToTheme >> icons: aThemeIcons [

	icons := aThemeIcons
]

{ #category : #initialization }
ToTheme >> initialize [

	super initialize.
	tokenProperties := self technicalTokenProperties asOrderedCollection.
	tokenProperties addAll: self defaultTokenProperties
]

{ #category : #accessing }
ToTheme >> name [

	^ self class label
]

{ #category : #accessing }
ToTheme >> newSkinFor: anElement [

	^ self subclassResponsibility 
]

{ #category : #'api - hooks' }
ToTheme >> onInstalledIn: anElement [

	(Pragma allNamed: #toploThemeInstaller) do: [ :each |
		each methodClass soleInstance
			perform: each methodSelector
			with: self ].

	anElement addAllTokenProperties: self tokenProperties.
	anElement toThemeInstalled
]

{ #category : #'api - hooks' }
ToTheme >> onUninstalledIn: anElement [

	anElement removeAllTokenPropertiesFromNames:
		(self tokenProperties collect: [ :tp | tp name ]).
	anElement toThemeUninstalled: self
]

{ #category : #printing }
ToTheme >> printOn: aStream [

	super printOn: aStream.
	aStream
		nextPutAll: ' [ ';
		nextPutAll: self name;
		nextPutAll: ' ]'
]

{ #category : #styling }
ToTheme >> styleSheet [ 

	^ nil
]

{ #category : #accessing }
ToTheme >> technicalTokenProperties [

	^ self class technicalTokenProperties
]

{ #category : #accessing }
ToTheme >> tokenProperties [

	^ tokenProperties 
]
