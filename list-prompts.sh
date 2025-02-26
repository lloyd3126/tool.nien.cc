#!/bin/bash

# 生成Markdown格式的資料夾和檔案結構
# 用法: ./script.sh /path/to/directory

generate_markdown() {
    local target_dir=$1
    local base_dir=$(basename "$target_dir")
    
    # echo "## $base_dir"
    # echo ""
    
    # 遍歷主資料夾
    for main_dir in "$target_dir"/*/ ; do
        if [ -d "$main_dir" ]; then
            local main_dirname=$(basename "$main_dir")
            echo "### $main_dirname"
            
            # 找出此資料夾中的所有.md檔案
            for file in "$main_dir"/*.md ; do
                if [ -f "$file" ]; then
                    local filename=$(basename "$file" .md)
                    # 創建相對路徑連結
                    echo "- [$filename](./$base_dir/$main_dirname/$filename)"
                fi
            done
            echo ""
        fi
    done
}

# 主程序
if [ $# -eq 0 ]; then
    echo "請提供資料夾路徑"
    exit 1
fi

target_dir=$1

if [ ! -d "$target_dir" ]; then
    echo "錯誤：'$target_dir' 不是有效的資料夾"
    exit 1
fi

# 將輸出保存到 ./prompts.md 文件
generate_markdown "$target_dir" > ./prompts.md

echo "已生成 Markdown 文件: ./prompts.md"
