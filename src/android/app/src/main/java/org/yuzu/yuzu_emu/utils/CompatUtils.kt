// Copyright 2024 Mandarine Project
// Licensed under GPLv2 or any later version
// Refer to the license.txt file included.

// SPDX-FileCopyrightText: Copyright yuzu/Citra Emulator Project / Eden Emulator Project
// SPDX-License-Identifier: GPL-3.0-or-later

package org.yuzu.yuzu_emu.utils

import android.app.Activity
import android.content.Context
import android.content.ContextWrapper

object CompatUtils {
    fun findActivity(context: Context): Activity {
        return when (context) {
            is Activity -> context
            is ContextWrapper -> findActivity(context.baseContext)
            else -> throw IllegalArgumentException("Context is not an Activity")
        }
    }
}
